class TasksController < ApplicationController
  include IndexConcern
  include CreateConcern
  include UpdateConcern
  include DestroyConcern

  before_action :authenticate_user!

  respond_to :json

  private

  def repo
    @repo ||= TasksRepository.new(current_user, params)
  end
end