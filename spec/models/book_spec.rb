require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:model) { build :book }

  let(:invalid_isbn_codes) do
    JSON.parse file_fixture("invalid_isbn_codes.json").read
  end

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
