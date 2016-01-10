class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project

  respond_to :json

  def index 
    tasks = @project.tasks.all
    render json: tasks, status: :ok
  end

  def create
    task = Task.new(task_params)
    if task.valid? && task.save
      render json: task, status: :created
    else
      render json: task.errors, status: :unprocessable_entity
    end
  end

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

  def destroy
    if task.destroy
      head :no_content
    else
      head :unprocessable_entity
    end
  end

  private

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