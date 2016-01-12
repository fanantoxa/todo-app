module CreateConcern
  def create
    service = CreateService.new(self, repo) do |on|
      on.success { |item|
        render json: item.to_json, status: :created
      }
      on.failure { |item|
        render json: item.to_json, status: :unprocessable_entity
      }
    end
    service.run
  end
end