class BaseRepository
  def initialize(current_user, params)
    @current_user = current_user
    @params = params
  end

  private

  def filter_params(params, filter)
    params.select {|k, v| filter.include? k }
  end
end