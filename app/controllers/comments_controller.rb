class CommentsController < ApplicationController
  include IndexConcern
  include DestroyConcern
  include CreateConcern

  before_action :authenticate_user!

  respond_to :json

  private 

  def repo
    @repo ||= CommentsRepository.new(current_user, params)
  end
end