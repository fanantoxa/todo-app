class ProjectsController < ApplicationController
  before_action :authenticate_user!

  respond_to :json

  before_action :set_project, only: [:update, :destroy]

  def index
    projects = Project.all
    render json: projects.to_json, status: :ok
  end

  def create
    project = Project.new(project_params)

    if project.valid? && project.save
      render json: project, status: :created
    else
      render json: project.errors, status: :unprocessable_entity
    end
  end

  def update
    if @project.update(project_params)
      render json: @project, status: :ok
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @project.destroy
      head :no_content
    else
      head :unprocessable_entity
    end
  end

  private
    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.permit(:name).merge(user: current_user)
    end
end