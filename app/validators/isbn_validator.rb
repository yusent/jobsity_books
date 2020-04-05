class IsbnValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.nil? || valid_isbn_code?(value)
      record.errors[attribute] << (options[:message] || "is not an ISBN code")
    end
  end

  def valid_isbn_code?(code)
    !Isbn.parse(code).nil?
  end
end
