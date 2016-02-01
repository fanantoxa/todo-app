module Todo
  class TaskListSection < SitePrism::Section
    element :item,              '.task'
    element :item_status,       '.task .status input'
    element :item_name,         '.task .task-text'

    element :item_date,         '.task .date .date-text'
    element :item_datapicker,       '.task .dropdown-menu'
    element :item_datapicker_today, '.task .dropdown-menu .pull-left button.btn-info'
    element :item_datapicker_clear, '.task .dropdown-menu .pull-left button.btn-danger'
    element :item_date_icon,        '.task .date .date-icon'

    element :item_edit_btn,     '.task .edit span'
    element :item_delete_btn,   '.task .remove span'
    element :item_comments_btn, '.task .comments-icon span'


    element :from,            '.form'
    element :form_name,       '.form .task-text input'
    element :form_apply_btn,  '.form .apply span'
    element :form_cancel_btn, '.form .cancel span'
  end
end