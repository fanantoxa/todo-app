module Todo
  class ProjectListSection < SitePrism::Section
    element :item_name,       '.item .project-name'
    element :item_delete_btn, '.item .remove'
    element :item_edit_btn,   '.item .edit'

    element :form_name,       '.form .project-name'
    element :form_cancel_btn, '.form .cancel'
    element :item_apply_btn,  '.form .apply'
  end
end