class IsbnValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.nil? || valid_isbn_code?(value)
      record.errors.add attribute, :invalid
    end
  end

  def valid_isbn_code?(code)
    !IsbnParser.parse(code).nil?
  end
end
