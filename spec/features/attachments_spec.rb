require 'features_helper'

describe 'Attachments section. ', features: true, js: true do
  let(:login_page) { Todo::LoginPage.new }
  let(:projects_page) { Todo::ProjectsPage.new }
  let(:user) { FactoryGirl.create :user }

  before do
    @project = FactoryGirl.create :project, user: user
    @task = FactoryGirl.create :task, project: @project
    @comment = FactoryGirl.create :comment, task: @task
    @attachment = FactoryGirl.create :attachment, comment: @comment
    login_page.load
    login_page.login_as user
    projects_page.wait_until_list_visible
    first_project = projects_page.list.first
    first_project.wait_until_task_list_visible
    first_task = first_project.task_list.first
    first_task.item_comments_btn.click
    @first_comment = first_task.comment_list.first
    @first_comment.wait_until_attachment_list_visible
  end

  feature 'I want be able to see link for adding attachment' do
    scenario 'displayed' do
      expect(@first_comment.attachment_form).to have_upload_link
    end
  end
end