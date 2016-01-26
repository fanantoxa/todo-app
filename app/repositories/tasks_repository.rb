class TasksRepository < BaseRepository
  FILTER = %w(name due_date status position)

  def initialize(current_user, params)
    super
    @project = @current_user.projects.find(@params['project_id'])
  end

  def list
    @project.tasks.all
  end

  def remove_item
    @project.tasks.find(@params['id']).destroy
  end

  def create_item
    @params['due_date'] = Date.parse(@params['due_date']) if @params['due_date']
    new_task = Task.new(prepared_params)
    status = new_task.valid? && new_task.save
    [status, new_task]
  end

  def update_item
    @params['due_date'] = Date.parse(@params['due_date']) if @params['due_date']
    task = @project.tasks.find(@params['id'])

    action = @params['position'] && :update_position || :update_field
    status = self.send(action, task)

    [status, task]
  end

  private

  def update_position(task)
    task.insert_at(@params['position'].to_i)
  end

  def update_field(task)
    task.update(prepared_params)
  end

  def prepared_params
    filter_params(@params, FILTER).merge(project: @project)
  end
end