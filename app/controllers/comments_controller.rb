class CommentsController < ApplicationController
  include IndexConcern
  include DestroyConcern
  include CreateConcern

  before_action :authenticate_user!
  before_action :set_task

  respond_to :json

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