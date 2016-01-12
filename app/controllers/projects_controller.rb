class ProjectsController < ApplicationController
  include IndexConcern
  include CreateConcern
  include UpdateConcern
  include DestroyConcern

  before_action :authenticate_user!

  respond_to :json

  private

  def repo
    @repo ||= ProjectsRepository.new(current_user, permited_params)
  end

  def permited_params
    params.permit(:name, :id)
  end
end
