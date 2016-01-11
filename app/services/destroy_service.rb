class DestroyService < BaseService
  def run
    item = @repo.remove_item

    if item
      success(item)
    else
      failure(item)
    end
  end
end