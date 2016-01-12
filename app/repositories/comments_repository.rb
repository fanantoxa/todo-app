class CommentsRepository < BaseRepository
  FILTER = %w(text)
  def initialize(current_user, params)
    super
    @task = @current_user.projects.find(@params['project_id']).tasks
      .find(@params['task_id'])
  end
  
  def list
    @task.comments.all
  end

  def remove_item
    @task.comments.find(@params['id']).destroy
  end

  def create_item
    new_progect = Comment.new(prepared_params)
    status = new_progect.valid? && new_progect.save
    [status, new_progect]
  end

  private

  def prepared_params
    filter_params(@params, FILTER).merge(task: @task)
  end
end