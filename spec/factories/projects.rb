FactoryGirl.define do
  factory :project do
    name Faker::Lorem.word
    association :user, factory: :user
  end
end