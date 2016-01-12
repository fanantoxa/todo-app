require 'rails_helper'

RSpec.describe BaseService do
  let(:context) { double }
  let(:repo) { double }
  let(:service) { BaseService.new(context, repo) }

  describe '#run' do
    it 'should raise exception' do
      expect(service.run).to eq('Action not described')
    end
  end
end