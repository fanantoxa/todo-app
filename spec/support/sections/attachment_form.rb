module Todo
  class AttachmentFormSection < SitePrism::Section
    element :upload_link, '.upload_link_container'
    element :upload_input, 'input'
    elements :progress_bars, '.progress'
  end
end