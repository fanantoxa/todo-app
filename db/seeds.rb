# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
case Rails.env
when 'development'
when 'test'
  User.create!(email: 'test@test.test', 
             password: 'testing1', 
             password_confirmation: 'testing1')
when 'production'
  # production seeds (if any) ...

end
