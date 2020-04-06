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

  describe "search_by_isbn scope" do
    it "filters books by ISBN code" do
      isbn_codes = JSON.parse file_fixture("valid_isbn_codes.json").read
      isbn_codes.each { |isbn| create :book, isbn: isbn }

      expect(Book.count).to eq(6)
      expect(Book.search_by_isbn("164093054X").count).to eq(1)
      expect(Book.search_by_isbn("ISBN-10: 1-640-93054-X").count).to eq(1)
      expect(Book.search_by_isbn("9781640930544").count).to eq(1)
      expect(Book.search_by_isbn("ISBN: 978-1-64-093054-4").count).to eq(1)
      expect(Book.search_by_isbn("ISBN-13: 978-1-64-093054-4").count).to eq(1)
      expect(Book.search_by_isbn("978-1-64-093054-4").count).to eq(1)
    end
  end

  describe "before_save" do
    it "stores the ISBN code using standard format" do
      book = create :book, isbn: "1933988673"
      expect(book.isbn).to eq("ISBN-10: 1-933-98867-3")

      book = create :book, isbn: "9781640930544"
      expect(book.isbn).to eq("ISBN-13: 978-1-64-093054-4",)
    end
  end
end
