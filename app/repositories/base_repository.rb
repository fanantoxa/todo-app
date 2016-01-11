class BaseRepository
  def initialize(current_user, params)
    @current_user = current_user
    @params = params
  end
end