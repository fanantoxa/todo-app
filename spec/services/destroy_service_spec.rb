require 'rails_helper'

RSpec.describe DestroyService do
  let(:context) { double(invoked: true) }
  let(:repo) { double(remove_item: item) }
  let(:service) { 
    DestroyService.new(context, repo) do |on|
      on.success { |a| context.invoked("SUCCESS", a) }
      on.failure { |a| context.invoked("FAILURE", a) }
    end
  }

  describe '#run' do
    describe 'success action' do
      let(:item) { true }

      it 'should call success block' do
        service.run
        expect(context).to have_received(:invoked).with("SUCCESS", item)
      end
    end

    describe 'failure action' do
      let(:item) { false }

      it 'should call failure block' do
        service.run
        expect(context).to have_received(:invoked).with("FAILURE", item)
      end
    end
  end
end