module Todo
  class TaskFormSection < SitePrism::Section
    element :name,    'input'
    element :add_btn, 'button'

    def add_new (task)
      name.set task.name
      add_btn.click
    end
  end
end