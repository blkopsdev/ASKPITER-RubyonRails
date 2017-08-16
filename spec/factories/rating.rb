FactoryGirl.define do
  factory :rating do
    trait :with_value do
      value 5
    end
  end
end
