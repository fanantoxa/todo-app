FactoryGirl.define do
  factory :attachment do
    name { Faker::Lorem.word }
    file File.open(Rails.root.join 'spec/fixtures/images/1.jpg')
  end
end


