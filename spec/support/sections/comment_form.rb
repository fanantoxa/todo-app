module Todo
  class CommentFormSection < SitePrism::Section
    element :text,    'textarea'
    element :add_btn, 'button'

    def add_new (comment)
      text.set comment.text
      add_btn.click
    end
  end
end