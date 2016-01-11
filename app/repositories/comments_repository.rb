class CommentsRepository < BaseRepository
  def list
    @current_user.projects.find(@params[:project_id]).tasks
      .find(@params[:task_id]).comments.all
  end
end