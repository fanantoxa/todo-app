class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task

  respond_to :json

  def index
    comments = @task.comments.all
    render json: comments, status: :ok
  end

  def create
    comment = Comment.new(comment_params)
    if comment.valid? && comment.save
      render json: comment, status: :created
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    comment = @task.comments.find(params[:id])
    
    if comment.destroy
      head :no_content
    else
      head :unprocessable_entity
    end
  end

  private 

  def set_task
    project = current_user.projects.find(params[:project_id])
    @task = project.tasks.find(params[:task_id])
  end

  def comment_params
    params.permit(:text).merge(task: @task)
  end
end