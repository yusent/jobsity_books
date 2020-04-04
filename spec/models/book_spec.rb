require 'rails_helper'

RSpec.describe Book, type: :model do
  # Presence validations
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:author) }
  it { should validate_presence_of(:isbn) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:short_description) }
end
