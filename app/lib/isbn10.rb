class Isbn10
  include Isbn

  # FMI: https://bit.ly/2V72HlN
  def self.regex
    %r{
      ^
      (?:ISBN(?:-?10)?:?\ )?    # Optional ISBN/ISBN-10 identifier.
      (?=                       # Basic format pre-checks (lookahead):
        [0-9X]{10}$             #   Require 10 digits/Xs (no separators).
       |                        #  Or:
        (?=(?:[0-9]+[-\ ]){3})  #   Require 3 separators
        [-\ 0-9X]{13}$          #     out of 13 characters total.
      )                         # End format pre-checks.
      ([0-9]{1,5}[-\ ]?         # 1-5 digit group identifier.
      [0-9]+[-\ ]?[0-9]+[-\ ]?) # Publisher and title identifiers.
      ([0-9X])                  # Check digit.
      $
    }x
  end

  def self.calc_check_digit(digits)
    sum = digits.each_with_index.sum { |digit, i| digit * (10 - i) }
    check_digit = 11 - sum % 11

    if check_digit == 10
      "X"
    elsif check_digit == 11
      "0"
    else
      check_digit.to_s
    end
  end

  def to_s
    sections = [0, 1..3, 4..8, 9]
    digits = [*@digits, @check_digit]
    string = sections.map { |section| [*digits[section]].join }.join("-")
    "ISBN-10: #{string}"
  end
end
