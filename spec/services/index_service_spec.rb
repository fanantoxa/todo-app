require 'rails_helper'

RSpec.describe IndexService do
  let(:context) { double }
  let(:some_list) { [1,2,4,6]}
  let(:repo) { double(list: some_list) }
  let(:service) { IndexService.new(context, repo) }

  describe '#run' do
    it 'should get the list from repo' do
      expect(service.run).to eq(some_list)
    end
  end
end