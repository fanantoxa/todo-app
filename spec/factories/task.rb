FactoryGirl.define do
  factory :task do
    name Faker::Lorem.word
    association :project, factory: :project
  end
end