require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  before(:each) do
    user = User.find_by(email: 'test@test.test')
    sign_in user
  end

  describe '#index' do

    it 'should return all projects' do
      get :index, :format => :json
      expect(JSON.parse(response.body).count).to eq(2)
      expect(response).to have_http_status(:ok)
    end
  end
end