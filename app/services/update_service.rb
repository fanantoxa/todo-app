class UpdateService < BaseService
  def run
    status, item = @repo.update_item

    if status
      success(item)
    else
      failure(item.errors)
    end
  end
end