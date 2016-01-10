require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  before(:each) do
    @user = User.find_by(email: 'test@test.test')
    sign_in @user
    @project = @user.projects.find_by(name: 'Test project')
    @task = @project.tasks.find_by(name: 'test task 1')
  end

  describe '#index' do 
    it 'should return all comments' do
      get :index, project_id: @project.id, task_id: @task.id, format: :json
      expect(JSON.parse(response.body).count).to eq(4)
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#create' do
    it 'should create new task' do
      post :create, project_id: @project.id, task_id: @task.id,
        text: 'new comment', format: :json
      expect(response).to have_http_status(:created)
    end

    it 'should return validation errors' do
      post :create, project_id: @project.id, task_id: @task.id,
        text: '', format: :json
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body).count).to eq(1)
    end
  end

  describe '#destroy' do
    let(:comment) { @task.comments.first }

    it 'should remove existing comment' do
      delete :destroy, project_id: @project.id, task_id: @task.id, id: comment.id, format: :json
      expect(response).to have_http_status(:no_content)
    end
  end
end