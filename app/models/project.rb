class Project < ActiveRecord::Base
  belongs_to :user
  has_many :tasks, -> { order(position: :asc) }, dependent: :destroy

  validates :name, presence: true, length: { maximum: 250 }
end
