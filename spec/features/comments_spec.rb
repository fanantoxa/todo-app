require 'features_helper'

describe 'Comment page.', features: true, js: true do
  let(:login_page) { Todo::LoginPage.new }
  let(:projects_page) { Todo::ProjectsPage.new }
  let(:user) { FactoryGirl.create :user }

  before do
    @project = FactoryGirl.create :project, user: user
    @task = FactoryGirl.create :task, project: @project
    @comment = FactoryGirl.create :comment, task: @task
    login_page.load
    login_page.login_as user
    projects_page.wait_until_list_visible
    projects_page.list.first.wait_until_task_list_visible
    @first_task = projects_page.list.first.task_list.first
    @first_task.item_comments_btn.click
  end

  feature 'I want be able to see from for adding comment' do
    scenario 'displayed' do
      expect(@first_task.comment_form).to have_text
      expect(@first_task.comment_form).to have_add_btn
    end
  end

  feature 'I want be able to see already created commentss' do
    before do
      @first_comment_item = @first_task.comment_list.first
    end

    scenario 'should be presented with already creadted comment' do
      expect(@first_task).to have_comment_list count: 1, wait: 5

      expect(@first_comment_item).to have_text
      expect(@first_comment_item.text).to have_content @comment.text

      expect(@first_comment_item).to have_remove_btn
    end
  end

  feature 'I want be able add comments' do
    let(:new_comment) { FactoryGirl.build :comment }

    scenario 'successful' do
      @first_task.comment_form.add_new new_comment
      expect(@first_task).to have_comment_list count: 2, wait: 2
    end

    scenario 'with error'
  end

  feature 'I want be able remove projects' do
    scenario 'successful' do
      @first_task.comment_list.first.remove_btn.click
      expect(@first_task).to have_comment_list count: 0, wait: 5
    end
  end
end