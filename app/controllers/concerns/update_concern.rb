module UpdateConcern
  def update
    service = UpdateService.new(self, repo) do |on|
      on.success { |item|
        render json: item.to_json, status: :ok
      }
      on.failure { |item|
        render json: item.to_json, status: :unprocessable_entity
      }
    end
    service.run
  end
end