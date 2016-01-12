FactoryGirl.define do
  factory :comment do
    text Faker::Lorem.sentence
    association :task, factory: :task
  end
end