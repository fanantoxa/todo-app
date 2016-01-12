require 'rails_helper'

RSpec.describe NamedCallbacks do
  let(:named_callbacks) { NamedCallbacks.new }
  let(:args) { [ ] }

  describe '#call' do
    it "with a named callback" do
      named_callbacks.ok { |*a| args.replace(a) }
      named_callbacks.call(:ok, 1, 2, 3)
      expect(args).to eq([1, 2, 3])
    end

    it "with a named callback called by a string" do
      named_callbacks.ok { |*a| args.replace(a) }
      named_callbacks.call("ok", 1, 2, 3)
      expect(args).to eq([1, 2, 3])
    end

    it "with a undeclared callback" do
      expect(named_callbacks.call(:ok, 1, 2, 3)).to eq(true)
    end
  end
end