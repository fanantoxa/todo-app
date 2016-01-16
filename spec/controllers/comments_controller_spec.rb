require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  before(:each) do
    @user = FactoryGirl.create :user
    @project = FactoryGirl.create :project, user: @user
    @task = FactoryGirl.create :task, project: @project
    @comment = FactoryGirl.create :comment, task: @task
    sign_in @user
  end

  describe '#index' do 
    it 'should return all comments' do
      get :index, project_id: @comment.task.project.id,
        task_id: @comment.task.id, format: :json
      expect(JSON.parse(response.body).count).to eq(1)
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#create' do
    it 'should create new task' do
      post :create, project_id: @comment.task.project.id,
        task_id: @comment.task.id, text: 'new comment', format: :json
      expect(response).to have_http_status(:created)
    end

    it 'should return validation errors' do
      post :create, project_id: @comment.task.project.id,
        task_id: @comment.task.id, text: '', format: :json
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body).count).to eq(1)
    end
  end

  describe '#destroy' do

    it 'should remove existing comment' do
      delete :destroy, project_id: @comment.task.project.id,
        task_id: @comment.task.id, id: @comment.id, format: :json
      expect(response).to have_http_status(:no_content)
    end
  end
end