class ProjectsRepository < BaseRepository
  def initialize(current_user, params)
    super
    @projects = @current_user.projects
  end

  def list
    @projects.all
  end

  def remove_item
    @projects.find(@params[:id]).destroy
  end
end