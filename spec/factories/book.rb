FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    author  { Faker::Book.author }
    price { Faker::Commerce.price range: 100..999.99 }
    short_description { Faker::Lorem.sentence }

    isbn do
      digits = 9.times.map { rand(0..9) }
      digits = [9, 7, rand(8..9), *digits] if rand > 0.5
      isbn_class = digits.length == 9 ? Isbn10 : Isbn13
      check_digit = isbn_class.calc_check_digit digits
      isbn_class.new(digits, check_digit).to_s
    end
  end
end
