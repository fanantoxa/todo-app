require 'features_helper'

describe 'Comment page.', features: true, js: true do
  let(:login_page) { Todo::LoginPage.new }
  let(:projects_page) { Todo::ProjectsPage.new }
  let(:user) { FactoryGirl.create :user }

  before do
    @project = FactoryGirl.create :project, user: user
    @task = FactoryGirl.create :task, project: @project
    @comment = FactoryGirl.create :comment, task: @task, project: @project
    login_page.load
    login_page.login_as user
    projects_page.wait_until_list_visible
    projects_page.list.first.wait_until_task_list_visible
    @first_task = projects_page.list.first.task_list.first
    @first_task.item_comments_btn.click
  end

  feature 'I want be able to see from for adding comment' do
    scenario 'displayed'
  end

  feature 'I want be able to see already created commentss' do
    scenario 'should be presented with already creadted comment'
  end

  feature 'I want be able add comments' do
    scenario 'successful'
    scenario 'with error'
  end

  feature 'I want be able remove projects' do
    scenario 'successful'
  end
end