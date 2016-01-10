class Task < ActiveRecord::Base
  belongs_to :project
  acts_as_list scope: :project

  validates :name, presence: true, length: { maximum: 250 }
end
