class HomeController < ApplicationController
  layout "home"

  def index
    render text: "", layout: true
  end
end