require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  before(:each) do
    @attachment = FactoryGirl.create :attachment
    sign_in @attachment.comment.task.project.user
  end

  describe '#index' do
    it 'should return all files' do
      get :index, project_id: @attachment.comment.task.project.id,
        task_id: @attachment.comment.task.id,
        comment_id: @attachment.comment.id, format: :json
      expect(JSON.parse(response.body).count).to eq(1)
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#create' do
    before do
      @file = fixture_file_upload('images/1.jpg', 'image/jpeg')
    end

    it 'should upload file to server' do
      post :create, project_id: @attachment.comment.task.project.id,
        task_id: @attachment.comment.task.id, comment_id: @attachment.comment.id,
        file: @file,
        format: :json
      expect(response).to have_http_status(:created)
    end
  end

  describe '#destroy' do
    it 'should remove existing comment' do
      delete :destroy, project_id: @attachment.comment.task.project.id,
        task_id: @attachment.comment.task.id,
        comment_id: @attachment.comment.id, id: @attachment.id, format: :json
      expect(response).to have_http_status(:no_content)
    end
  end
end