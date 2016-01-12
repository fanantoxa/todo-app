require 'rails_helper'

RSpec.describe Attachment, type: :model do
  describe 'relations' do
    it { expect(subject).to belong_to(:comment) }
  end

  describe 'validation' do
    it { expect(subject).to validate_presence_of(:name) }
    it { expect(subject).to validate_presence_of(:file) }
  end
end
