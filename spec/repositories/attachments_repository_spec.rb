require 'rails_helper'

RSpec.describe AttachmentsRepository do
  let(:attachment)      { double( destroy: 'done') }
  let(:all_attachment) { [1,2,3] }
  let(:attachments) {double(find: attachment, all: all_attachment)}
  let(:comment)      { double(attachments: attachments) }
  let(:comments)     { double(find: comment) }
  let(:task)         { double(comments: comments) }
  let(:tasks)        { double(find: task) }
  let(:project)      { double(tasks: tasks) }
  let(:projects)     { double(find: project) }
  let(:current_user) { double( projects: projects)}

  let(:permit_params) { double(merge: 'params') }
  let(:file) { double(original_filename: 'some name') }
  let(:params) {{'file' => file, 'project_id' => 1, 'task_id' => 2, 'id' => 3}}
  let(:repository) { AttachmentsRepository.new(current_user, params) }
  let(:attachment_model) { double(valid?: true, save: true) }

  before do
    allow(Attachment).to receive(:new).and_return(attachment_model)
  end

  describe '#list' do
    it 'should return comments list' do
      expect(repository.list).to eq(all_attachment)
    end
  end

  describe '#remove_item' do
    it 'should destroy comment' do
      expect(repository.remove_item).to eq('done')
      expect(attachment).to have_received(:destroy)
    end
  end

  describe '#create_item' do
    it 'should create comment' do
      expect(repository.create_item).to eq([true, attachment_model])
      expect(Attachment).to have_received(:new).with({file: file, name: 'some name', comment: comment})
    end
  end
end