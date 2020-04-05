module Isbn
  def self.included(klass)
    klass.extend ClassMethods
  end

  module ClassMethods
    # A regex with the specific format
    def regex
      raise "Not implemented"
    end

    # A method for calculating the check-digit taking an array of digits (int) as
    # parameter
    def calc_check_digit(digits)
      raise "Not implemented"
    end

    def parse(string)
      match = string.match regex
      return nil if match.nil?

      digits = match[1].gsub(/\D/, "").split("").map(&:to_i)
      check_digit = match[2]
      return nil if calc_check_digit(digits) != check_digit

      new digits, check_digit
    end
  end

  def initialize(digits, check_digit)
    @digits = digits
    @check_digit = check_digit
  end
end
