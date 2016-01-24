FactoryGirl.define do
  factory :task do
    name Faker::Lorem.word
    due_date Faker::Date.forward(10)
  end
end