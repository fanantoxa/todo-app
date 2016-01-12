class Attachment < ActiveRecord::Base
  belongs_to :comment
  mount_uploader :file, AttachmentUploader

  validates :name, presence: true
  validates :file, presence: true
end
