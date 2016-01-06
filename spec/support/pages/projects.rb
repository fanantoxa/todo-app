module Todo
  class ProjectsPage < SitePrism::Page
    set_url '#/projects'

    element :projects, '#projects'
  end
end
