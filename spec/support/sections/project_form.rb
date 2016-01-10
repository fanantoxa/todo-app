module Todo
  class ProjectFormSection < SitePrism::Section
    element :name,    'input'
    element :add_btn, 'button'
  end
end