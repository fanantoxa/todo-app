require_relative 'task_form'
require_relative 'task_list'

module Todo
  class ProjectListSection < SitePrism::Section
    element :item,            '.item'
    element :item_name,       '.item .project-name'
    element :item_delete_btn, '.item .remove'
    element :item_edit_btn,   '.item .edit'

    element :from,            '.form'
    element :form_name,       '.form .project-name input'
    element :form_cancel_btn, '.form .cancel'
    element :form_apply_btn,  '.form .apply'

    section :task_form, TaskFormSection, '.tasks .task-form'
    sections :task_list, TaskListSection, '.tasks .task-container'
  end
end