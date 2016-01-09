class ApplicationController < ActionController::Base
  respond_to :json
  skip_before_filter :set_xsrf_token_cookie if Rails.env.test?
end
