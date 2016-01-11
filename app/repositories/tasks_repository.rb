class TasksRepository < BaseRepository
  def list
    @current_user.projects.find(@params[:project_id]).tasks.all
  end
end