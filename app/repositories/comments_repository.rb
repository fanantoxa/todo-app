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
    new_comment = Comment.new(prepared_params)
    status = new_comment.valid? && new_comment.save
    [status, new_comment]
  end

  private

  def prepared_params
    filter_params(@params, FILTER).merge(task: @task)
  end
end