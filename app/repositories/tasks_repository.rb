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

  def update_item
    task = @project.tasks.find(@params[:id])

    action = @params.include?(:position) && :update_position || :update_field
    status = self.send(action, task)

    [status, task]
  end

  private

  def update_position(task)
    task.insert_at(@params[:position].to_i)
  end

  def update_field(task)
    task.update(filter_params)
  end

  def filter_params
    @params.permit(:name, :due_date, :status, :position).merge(project: @project)
  end
end