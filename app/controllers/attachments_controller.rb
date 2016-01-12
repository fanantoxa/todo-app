class AttachmentsController < ApplicationController
  include IndexConcern
  include CreateConcern
  include DestroyConcern

  before_action :authenticate_user!

  private

  def repo
    @repo ||= AttachmentsRepository.new(current_user, permited_params)
  end

  def permited_params
    params.permit(:file, :id, :project_id, :task_id, :comment_id)
  end
end