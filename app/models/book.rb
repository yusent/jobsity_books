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
end
