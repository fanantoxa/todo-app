FactoryGirl.define do
  factory :user do
    email                 'test@test.test'
    password              'testing1'
    password_confirmation 'testing1'
  end

  factory :not_exit_user, class: User do
    email                 Faker::Internet.email
    password              'testing1'
    password_confirmation 'testing1'
  end
end