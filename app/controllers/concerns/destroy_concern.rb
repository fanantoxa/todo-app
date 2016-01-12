module DestroyConcern
  def destroy
    service = DestroyService.new(self, repo) do |on|
      on.success { |item|
        render json: item.to_json, status: :no_content
      }
      on.failure { |item|
        render json: item.to_json, status: :unprocessable_entity
      }
    end
    service.run
  end
end