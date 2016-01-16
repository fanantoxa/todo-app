require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  before(:each) do
    @user = FactoryGirl.create :user
    @project = FactoryGirl.create :project, user: @user
    @task = FactoryGirl.create :task, project: @project
    sign_in @user
  end
    
  describe '#index' do

    it 'should return all tasks' do
      get :index, project_id: @task.project.id ,format: :json
      expect(JSON.parse(response.body).count).to eq(1)
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#create' do

    it 'should create new task' do
      post :create, project_id: @task.project.id, name: 'new task', format: :json
      expect(response).to have_http_status(:created)
    end

    it 'should create new task with due date' do
      post :create, project_id: @task.project.id, name: 'new task',
        due_date: Time.new ,format: :json
      expect(response).to have_http_status(:created)
    end

    it 'should return validation errors' do
      post :create, project_id: @task.project.id, name: '', format: :json
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body).count).to eq(1)
    end
  end

  describe '#update' do
    it 'should update name of existing task' do
      put :update, project_id: @task.project.id, id: @task.id, name: 'some other name', format: :json
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['name']).to eq('some other name')
    end

    it 'should update status of existing task' do
      put :update, project_id: @task.project.id, id: @task.id, status: true, format: :json
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['status']).to eq(true)
    end

    it 'should update due_date of existing task' do
      time = DateTime.now.utc.to_s
      put :update, project_id: @task.project.id, id: @task.id, due_date: time, format: :json
      expect(response).to have_http_status(:ok)
      expect(DateTime.parse(JSON.parse(response.body)['due_date']).utc).to eq(time)
    end

    it 'should update position of existing task' do
      put :update, project_id: @task.project.id, id: @task.id, position: 3, format: :json
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['position']).to eq(3)
    end

    it 'should return validation errors' do
      put :update, project_id: @task.project.id, id: @task.id, name: '', format: :json
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe '#destroy' do
    it 'should remove existing task' do
      delete :destroy, project_id: @task.project.id, id: @task.id, format: :json
      expect(response).to have_http_status(:no_content)
    end
  end
end