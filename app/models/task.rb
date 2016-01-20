class Task < ActiveRecord::Base
  belongs_to :project
  has_many :comments, dependent: :destroy
  acts_as_list scope: :project, top_of_list: 0, add_new_at: :top

  validates :name, presence: true, length: { maximum: 250 }
end
