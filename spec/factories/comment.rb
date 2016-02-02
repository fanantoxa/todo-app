FactoryGirl.define do
  factory :comment do
    text { Faker::Lorem.sentence }
  end
end