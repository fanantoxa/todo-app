class ProjectsController < ApplicationController
  include IndexConcern
  include DestroyConcern

  before_action :authenticate_user!

  respond_to :json

  before_action :set_project, only: [:update, :destroy]

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

  private

  def repo
    @repo ||= ProjectsRepository.new(current_user, params)
  end
  
  def set_project
    @project = current_user.projects.find(params[:id])
  end

  def project_params
    params.permit(:name).merge(user: current_user)
  end
end
