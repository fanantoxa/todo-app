require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'relations' do
    it { expect(subject).to belong_to(:project) }
  end

  it { expect(subject).to validate_presence_of(:name) }
  it { expect(subject).to validate_length_of(:name).is_at_most(250) }
end
