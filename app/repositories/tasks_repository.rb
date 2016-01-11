class TasksRepository < BaseRepository
  def initialize(current_user, params)
    super
    @project = @current_user.projects.find(@params[:project_id])
  end

  def list
    @project.tasks.all
  end

  def remove_item
    @project.tasks.find(@params[:id]).destroy
  end

  def create_item
    new_progect = Task.new(filter_params)
    status = new_progect.valid? && new_progect.save
    [status, new_progect]
  end

  private

  def filter_params
    @params.permit(:name, :due_date, :status, :position).merge(project: @project)
  end
end