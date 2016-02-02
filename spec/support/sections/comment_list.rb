module Todo
  class CommentListSection < SitePrism::Section
    element :text, '.comment-body p'
    element :remove, 'button'
  end
end