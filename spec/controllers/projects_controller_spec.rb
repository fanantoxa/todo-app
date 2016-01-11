require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  before(:each) do
    @project = FactoryGirl.create :project
    sign_in @project.user
  end

  describe '#index' do

    it 'should return all projects' do
      get :index, format: :json
      expect(JSON.parse(response.body).count).to eq(1)
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#create' do
    it 'should create new project' do
      post :create, name: 'test project', format: :json
      expect(response).to have_http_status(:created)
    end

    it 'should return validation errors' do
      post :create, name: '', format: :json
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body).count).to eq(1)
    end
  end

  describe '#update' do
    it 'should update existing project' do
      put :update, id: @project.id, name: 'some other name', format: :json
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['name']).to eq('some other name')
    end

    it 'should return validation errors' do
      put :update, id: @project.id, name: '', format: :json

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body).count).to eq(1)
    end
  end

  describe '#destroy' do
    it 'should remove existing project' do
      delete :destroy, id: @project.id, format: :json
      expect(response).to have_http_status(:no_content)
    end
  end
end