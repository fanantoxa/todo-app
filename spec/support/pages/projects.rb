module Todo
  class ProjectsPage < SitePrism::Page
    set_url '#/projects'

    element :projects,                  '#projects'
    section :form, ProjectFormSection,  '#projects .project-form'
    sections :list, ProjectListSection, '#projects .project-item'

    def add_new (project)
      form.name.set project.name
      form.add_btn.click
    end
  end
end
