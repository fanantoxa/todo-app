class CommentsController < ApplicationController
  include IndexConcern
  include DestroyConcern

  before_action :authenticate_user!
  before_action :set_task

  respond_to :json

  def create
    comment = Comment.new(comment_params)
    if comment.valid? && comment.save
      render json: comment, status: :created
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  private 

  def repo
    @repo ||= CommentsRepository.new(current_user, params)
  end

  def set_task
    project = current_user.projects.find(params[:project_id])
    @task = project.tasks.find(params[:task_id])
  end

  def comment_params
    params.permit(:text).merge(task: @task)
  end
end