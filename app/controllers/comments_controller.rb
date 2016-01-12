class CommentsController < ApplicationController
  include IndexConcern
  include CreateConcern
  include DestroyConcern

  before_action :authenticate_user!

  respond_to :json

  private 

  def repo
    @repo ||= CommentsRepository.new(current_user, permited_params)
  end

  def permited_params
    params.permit(:text, :id, :project_id, :task_id)
  end
end