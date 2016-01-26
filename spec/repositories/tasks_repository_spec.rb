require 'rails_helper'

RSpec.describe TasksRepository do
  let(:all_tasks) { [1,2,3] }
  let(:task)         { double(destroy: 'done') }
  let(:tasks)        { double(find: task, all: all_tasks) }
  let(:project)      { double(tasks: tasks) }
  let(:projects)     { double(find: project) }
  let(:current_user) { double( projects: projects)}

  let(:due_date) { Date.new}
  let(:permit_params) { double(merge: 'params') }
  let(:params) {{
    'project_id' => 1, 'id' => 3, 'position' => 3,
    'name' => 'na', 'due_date' => due_date.to_s, 'status' => true
    }}
  let(:repository) { TasksRepository.new(current_user, params) }
  let(:task_model) { double(valid?: true, save: true) }

  before do
    allow(Task).to receive(:new).and_return(task_model)
  end

  describe '#list' do
    it 'should return comments list' do
      expect(repository.list).to eq(all_tasks)
    end
  end

  describe '#remove_item' do
    it 'should destroy comment' do
      expect(repository.remove_item).to eq('done')
      expect(task).to have_received(:destroy)
    end
  end

  describe '#create_item' do
    it 'should create comment' do
      expect(repository.create_item).to eq([true, task_model])
      expect(Task).to have_received(:new).with({
        "position" => 3,
        "name" => "na",
        "due_date" => due_date,
        "status" => true,
        project: project
      })
    end
  end
end