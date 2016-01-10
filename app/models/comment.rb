class Comment < ActiveRecord::Base
  belongs_to :task

  validates :text, presence: true, length: { maximum: 1000 }
end
