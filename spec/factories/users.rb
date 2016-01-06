FactoryGirl.define do
  factory :user do
    email                 'test@test.test'
    password              'testing1'
    password_confirmation 'testing1'
  end

  factory :not_exist_user, class: User do
    email                 Faker::Internet.email
    password              'testing1'
    password_confirmation 'testing1'
  end

  factory :not_valid_user, class: User do
    email                 'dfg'
    password              'teng1'
    password_confirmation 't'
  end
end