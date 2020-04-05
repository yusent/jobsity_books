module IsbnParser
  SPLITTER_REGEX = /^(?:ISBN(?:-?\d*)?:?\s)?(.*)$/

  def self.parse(string)
    match = string.match SPLITTER_REGEX
    return nil if match.nil?

    base = match[1].gsub(/[^0-9X]/, "").length

    case base
    when 10
      Isbn10.parse string
    when 13
      Isbn13.parse string
    end
  end
end
