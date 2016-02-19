module Todo
  class AttachmentListSection < SitePrism::Section
    element :file_link, '.file_link'
    element :remove_btn, '.remove_btn'
  end
end