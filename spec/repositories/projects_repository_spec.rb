require 'rails_helper'

RSpec.describe ProjectsRepository do
  let(:all_project) { [1,2,3] }
  let(:project)      { double(destroy: 'done') }
  let(:projects)     { double(find: project, all: all_project) }
  let(:current_user) { double( projects: projects)}

  let(:permit_params) { double(merge: 'params') }
  let(:params) {{
    'name' => 'some name', 'project_id' => 1, 'task_id' => 2, 'id' => 3,
    }}
  let(:repository) { ProjectsRepository.new(current_user, params) }
  let(:project_model) { double(valid?: true, save: true) }

  before do
    allow(Project).to receive(:new).and_return(project_model)
  end

  describe '#list' do
    it 'should return comments list' do
      expect(repository.list).to eq(all_project)
    end
  end

  describe '#remove_item' do
    it 'should destroy comment' do
      expect(repository.remove_item).to eq('done')
      expect(project).to have_received(:destroy)
    end
  end

  describe '#create_item' do
    it 'should create comment' do
      expect(repository.create_item).to eq([true, project_model])
      expect(Project).to have_received(:new).with({
        "name" => "some name", user: current_user })
    end
  end
end