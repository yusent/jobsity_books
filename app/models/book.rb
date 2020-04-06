class Book < ApplicationRecord
  include Searchable

  scope :search_by_title, -> (title) do
    words = title.split /\W+/
    words.inject(all) do |results, word|
      results.where "title like ?", "%#{word}%"
    end
  end

  validates_presence_of :title, :author, :isbn, :price, :short_description
  validates :isbn, isbn: true

  before_save :apply_isbn_standard_format

  def apply_isbn_standard_format
    self.isbn = IsbnParser.parse(isbn).to_s
  end
end
