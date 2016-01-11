class ProjectsRepository < BaseRepository
  def list
    @current_user.projects.all
  end
end