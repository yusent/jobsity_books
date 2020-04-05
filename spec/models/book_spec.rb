require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:model) { build :book }

  let(:invalid_isbn_codes) do
    JSON.parse file_fixture("invalid_isbn_codes.json").read
  end

  describe "validations" do
    # Presence validations
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:author) }
    it { should validate_presence_of(:isbn) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:short_description) }

    it "should validate ISBN format" do
      expect(model).to be_valid

      invalid_isbn_codes.each do |isbn|
        expect(model).to_not allow_value(isbn).for(:isbn)
      end
    end
  end

  describe "search_by_title scope" do
    it "filters books by title" do
      books = JSON.parse file_fixture("books.json").read
      books.each { |book| create :book, title: book["title"] }

      expect(Book.count).to eq(394)
      expect(Book.search_by_title("in action").count).to eq(167)
    end
  end
end
