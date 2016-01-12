class CreateService < BaseService
  def run
    status, item = @repo.create_item

    if status
      success(item)
    else
      failure(item.errors)
    end
  end
end