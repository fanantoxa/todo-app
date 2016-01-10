require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'relations' do
    it { expect(subject).to belong_to(:task) }
  end

  describe 'validation' do
    it { expect(subject).to validate_presence_of(:text) }
    it { expect(subject).to validate_length_of(:text).is_at_most(1000) }
  end
end
