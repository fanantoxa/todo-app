require_relative 'attachment_form'
require_relative 'attachment_list'

module Todo
  class CommentListSection < SitePrism::Section
    element :text, '.comment-body p'
    element :remove_btn, 'button'

    section :attachment_form, AttachmentFormSection, '.comment-files .attach-form'
    sections :attachment_list, AttachmentListSection, '.comment-files .attached-file'
  end
end