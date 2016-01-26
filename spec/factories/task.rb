FactoryGirl.define do
  factory :task do
    name { Faker::Hipster.word }
    due_date Faker::Date.forward(10)
  end
end