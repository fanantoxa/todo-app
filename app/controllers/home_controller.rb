class HomeController < ApplicationController
  respond_to :html
  layout "home"

  def index
    render text: "", layout: true
  end
end