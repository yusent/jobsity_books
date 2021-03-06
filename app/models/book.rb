class Book < ApplicationRecord
  include Searchable

  scope :search_by_title, -> (title) do
    words = title.split /\W+/
    words.inject(all) do |results, word|
      results.where "title like ?", "%#{word}%"
    end
  end

  scope :search_by_isbn, -> (isbn) { where isbn: IsbnParser.parse(isbn).to_s }

  validates_presence_of :title, :author, :isbn, :price, :short_description
  validates_uniqueness_of :isbn
  validates_length_of :short_description, maximum: 150
  validates :isbn, isbn: true

  before_save :apply_isbn_standard_format

  def apply_isbn_standard_format
    self.isbn = IsbnParser.parse(isbn).to_s
  end
end
