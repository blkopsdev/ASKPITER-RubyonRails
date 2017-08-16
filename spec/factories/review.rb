FactoryGirl.define do
  factory :review do
    title 'Review title'
    review 'Review content'
    language
    user
    product
    trait :with_rating do
      association :rating, :with_value
    end
  end
end
