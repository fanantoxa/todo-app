class Comment < ActiveRecord::Base
  belongs_to :task
  has_many :attachments, dependent: :destroy

  validates :text, presence: true, length: { maximum: 1000 }
end
