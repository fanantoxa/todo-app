require 'rails_helper'

RSpec.describe CommentsRepository do
  let(:comment)      { double( destroy: 'done') }
  let(:all_comments) { [1,2,3] }
  let(:comments)     { double(all: all_comments, find: comment) }
  let(:task)         { double(comments: comments) }
  let(:tasks)        { double(find: task) }
  let(:project)      { double(tasks: tasks) }
  let(:projects)     { double(find: project) }
  let(:current_user) { double( projects: projects)}

  let(:permit_params) { double(merge: 'params') }
  let(:params) {{'text' => 'txt', 'project_id' => 1, 'task_id' => 2, 'id' => 3}}
  let(:repository) { CommentsRepository.new(current_user, params) }
  let(:comment_model) { double(valid?: true, save: true) }

  before do
    allow(Comment).to receive(:new).and_return(comment_model)
  end

  describe '#list' do
    it 'should return comments list' do
      expect(repository.list).to eq(all_comments)
    end
  end

  describe '#remove_item' do
    it 'should destroy comment' do
      expect(repository.remove_item).to eq('done')
      expect(comment).to have_received(:destroy)
    end
  end

  describe '#create_item' do
    it 'should create comment' do
      expect(repository.create_item).to eq([true, comment_model])
      expect(Comment).to have_received(:new).with({'text' => 'txt', task: task})
    end
  end
end