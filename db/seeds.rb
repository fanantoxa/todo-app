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
  User.all.map(&:destroy)
  user = User.create!(
    email: 'test@test.test', 
    password: 'testing1', 
    password_confirmation: 'testing1'
  )
  project = Project.create! name: 'Test project', user_id: user.id

  Project.create! name: 'Test project 2', user_id: user.id

  task = Task.create! name: 'test task 1', project_id: project.id
  Task.create! name: 'test task 2', project_id: project.id
  Task.create! name: 'test task 3', project_id: project.id

  comment = Comment.create! text: 'coment 1 text', task_id: task.id
  Comment.create! text: 'coment 2 text', task_id: task.id
  Comment.create! text: 'coment 3 text', task_id: task.id
when 'production'
  # production seeds (if any) ...

end
