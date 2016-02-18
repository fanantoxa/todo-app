module Todo
  class AttachmentFormSection < SitePrism::Section
    element :upload_link, '.upload_link'
    elements :progress_bars, '.progress'
  end
end