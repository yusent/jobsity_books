require 'rails_helper'

RSpec.describe IsbnValidator, type: :model do
  class self::ObjectWithISBN
    include ActiveModel::Validations
    attr_accessor :isbn
    validates :isbn, isbn: true
  end

  context "when correct ISBN format is used" do
    let(:model) { self.class::ObjectWithISBN.new }

    let(:valid_isbn_codes) do
      JSON.parse file_fixture("valid_isbn_codes.json").read
    end

    let(:invalid_isbn_codes) do
      JSON.parse file_fixture("invalid_isbn_codes.json").read
    end

    it "allows nil values" do
      expect(model).to allow_value(nil).for(:isbn)
    end

    it "allows values with the supported formats" do
      valid_isbn_codes.each do |isbn|
        expect(model).to allow_value(isbn).for(:isbn)
      end
    end

    it "allows values with the supported formats" do
      valid_isbn_codes.each do |isbn|
        expect(model).to allow_value(isbn).for(:isbn)
      end
    end

    it "disallows values with unsupported formats" do
      invalid_isbn_codes.each do |isbn|
        expect(model).to_not allow_value(isbn).for(:isbn)
      end
    end
  end
end
