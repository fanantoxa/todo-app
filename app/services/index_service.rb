class IndexService < BaseService
  def run
    @repo.list
  end
end