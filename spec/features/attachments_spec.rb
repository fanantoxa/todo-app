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

  feature 'I want be able to see already attached files' do
    before do
      @first_attachment = @first_comment.attachment_list.first
    end

    scenario 'should be presented with already attached files' do
      expect(@first_comment).to have_attachment_list count: 1, wait: 5

      expect(@first_attachment).to have_file_link
      expect(@first_attachment.file_link).to have_content @attachment.name
      expect(@first_attachment.file_link['href']).to have_content @attachment[:file]

      expect(@first_attachment).to have_remove_btn
    end
  end

  feature 'I want be able add comments' do
    let(:new_attachment) { FactoryGirl.build :attachment }

    scenario 'successful' do
      
      # @first_comment.attachment_form.upload_link.click
      @first_comment.attachment_form.upload_link.set new_attachment.file.path
      # attach_file @first_comment.attachment_form.upload_link, new_attachment.file.path, :visible => false
      expect(@first_comment).to have_attachment_list count: 2, wait: 2
    end

    scenario 'with error'
  end

  feature 'I want be able remove attached files' do
    scenario 'successful' do
      @first_comment.attachment_list.first.remove_btn.click
      expect(@first_comment).to have_attachment_list count: 0, wait: 5
    end
  end
end