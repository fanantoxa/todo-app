class TasksRepository < BaseRepository
  def initialize(current_user, params)
    super
    @tasks = @current_user.projects.find(@params[:project_id]).tasks
  end

  def list
    @tasks.all
  end

  def remove_item
    @tasks.find(@params[:id]).destroy
  end
end