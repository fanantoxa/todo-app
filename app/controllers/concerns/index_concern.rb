module IndexConcern
  def index
    list = IndexService.new(self, repo).run 
    render json: list.to_json, status: :ok
  end
end