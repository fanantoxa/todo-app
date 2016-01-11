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

  def create_item
    new_progect = Project.new(filter_params)
    status = new_progect.valid? && new_progect.save
    [status, new_progect]
  end

  def update_item
    project = @projects.find(@params[:id])
    status = project.update(filter_params)
    [status, project]
  end

  private

  def filter_params
    @params.permit(:name).merge(user: @current_user)
  end
end