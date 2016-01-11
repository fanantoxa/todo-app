class TasksController < ApplicationController
  include IndexConcern
  include DestroyConcern
  include CreateConcern

  before_action :authenticate_user!
  before_action :set_project

  respond_to :json

  def update
    result = if params[:position].present?
      task.insert_at(params[:position].to_i)
    else
      task.update(task_params)
    end
      
    if result
      render json: task, status: :ok
    else
      render json: task.errors, status: :unprocessable_entity
    end
  end

  private

  def repo
    @repo ||= TasksRepository.new(current_user, params)
  end

  def task
    @project.tasks.find(params[:id])
  end

  def set_project
    @project = current_user.projects.find(params[:project_id])
  end

  def task_params
    params.permit(:name, :due_date, :status, :position).merge(project: @project)
  end
end