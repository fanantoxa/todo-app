module Todo
  class ProjectListSection < SitePrism::Section
    element :project_name, '.project-name'
    element :delete_btn,   '.remove'
    element :edit_btn,     '.edit'
  end
end