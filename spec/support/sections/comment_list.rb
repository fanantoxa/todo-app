module Todo
  class CommentListSection < SitePrism::Section
    element :text, '.comment-body p'
    element :remove_btn, 'button'
  end
end