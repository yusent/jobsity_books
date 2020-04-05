class Book < ApplicationRecord
  validates_presence_of :title, :author, :isbn, :price, :short_description
  validates :isbn, isbn: true
end
