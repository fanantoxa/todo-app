class CommentsRepository < BaseRepository
  def initialize(current_user, params)
    super
    @comments = @current_user.projects.find(@params[:project_id]).tasks
      .find(@params[:task_id]).comments
  end
  
  def list
    @comments.all
  end

  def remove_item
    @comments.find(@params[:id]).destroy
  end
end