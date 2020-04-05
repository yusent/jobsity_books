class Isbn13
  include Isbn

  # FMI: https://bit.ly/2V72HlN
  def self.regex
    %r{
      ^
      (?:ISBN(?:-?13)?:?\ )?    # Optional ISBN/ISBN-13 identifier.
      (?=                       # Basic format pre-checks (lookahead):
        [0-9]{13}$              #   Require 13 digits (no separators).
       |                        #  Or:
        (?=(?:[0-9]+[-\ ]){4})  #   Require 4 separators
        [-\ 0-9]{17}$           #     out of 17 characters total.
      )                         # End format pre-checks.
      (97[89][-\ ]?             # ISBN-13 prefix.
      [0-9]{1,5}[-\ ]?          # 1-5 digit group identifier.
      [0-9]+[-\ ]?[0-9]+[-\ ]?) # Publisher and title identifiers.
      ([0-9])                   # Check digit.
      $
    }x
  end

  def self.calc_check_digit(digits)
    sum = digits.each_with_index.sum { |digit, i| digit * (i.even? ? 1 : 3) }
    check_digit = 10 - sum % 10
    check_digit == 10 ? "0" : check_digit.to_s
  end

  def to_s
    sections = [0..2, 3, 4..5, 6..11, 12]
    digits = [*@digits, @check_digit]
    string = sections.map { |section| [*digits[section]].join }.join("-")
    "ISBN-13: #{string}"
  end
end
