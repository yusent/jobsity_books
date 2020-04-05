class Isbn
  REGEX = %r{
    ^(?:ISBN(?:-?1[03])?:?\s)?                # Optional prefix
    (?=[0-9X]{10}$                            # ISBN-10 no separators
    |(?=(?:[0-9]+[- ]){3})[- 0-9X]{13}$       # ISBN-10 3 separators
    |(?=(?:[0-9]+[- ]))[0-9]{9}[- ][0-9X]$    # ISBN-10 1 separator
    |97[89][0-9]{10}$                         # ISBN-13 no separators
    |(?=(?:[0-9]+[- ]){4})[- 0-9]{17}$        # ISBN-13 4 separators
    |(?=(?:[0-9]+[- ]))[- 0-9]{12}[- ][0-9]$) # ISBN-13 1 separator
    ((?:97[89][- ]?)?                         # ISBN-13 prefix
    [0-9]{1,5}[- ]?                           # Group identifier
    [0-9]+[- ]?[0-9]+[- ]?)                   # Publisher and title identifiers
    ([0-9X])$                                 # Check digit
  }x

  def self.parse(string)
    match = string.match REGEX
    return nil if match.nil?

    digits = match[1].gsub(/\D/, "").split("").map(&:to_i)
    check_digit = match[2]
    return nil if calc_check_digit(digits) != check_digit

    new digits, check_digit
  end

  def self.calc_check_digit(digits)
    if digits.length == 9
      sum = digits.each_with_index.sum { |digit, i| digit * (10 - i) }
      check_digit = 11 - sum % 11

      if check_digit == 10
        "X"
      elsif check_digit == 11
        "0"
      else
        check_digit.to_s
      end
    else
      sum = digits.each_with_index.sum { |digit, i| digit * (i.even? ? 1 : 3) }
      check_digit = 10 - sum % 10
      check_digit == 10 ? "0" : check_digit.to_s
    end
  end

  def initialize(digits, check_digit)
    @digits = digits
    @base = @digits.length + 1
    @check_digit = check_digit
  end

  def to_s
    parts = @base == 10 ? [0, 1..3, 4..8, 9] : [0..2, 3, 4..5, 6..11, 12]
    digits = [*@digits, @check_digit]
    string = parts.map { |part| [*digits[part]].join }.join("-")
    "ISBN-#{@base}: #{string}"
  end
end
