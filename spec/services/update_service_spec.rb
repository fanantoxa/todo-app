require 'rails_helper'

RSpec.describe UpdateService do
  let(:context) { double(invoked: true) }
  let(:item) { double('item', errors: 'errors') }
  let(:repo) { double(update_item: [status, item]) }
  let(:service) { 
    UpdateService.new(context, repo) do |on|
      on.success { |a| context.invoked("SUCCESS", a) }
      on.failure { |a| context.invoked("FAILURE", a) }
    end
  }

  describe '#run' do
    describe 'success action' do
      let(:status) { true }

      it 'should call success block' do
        service.run
        expect(context).to have_received(:invoked).with("SUCCESS", item)
      end
    end

    describe 'failure action' do
      let(:status) { false }

      it 'should call failure block' do
        service.run
        expect(context).to have_received(:invoked).with("FAILURE", 'errors')
      end
    end
  end
end