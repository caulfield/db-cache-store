require 'test_helper'
require 'cache_assertions'

class CustomRepositoryTest < Minitest::Test
  include CacheAssertions

  def cache
    ActiveSupport::Cache.lookup_store(:db_store, repository: repository)
  end

  def setup
    repository.delete_all
  end

  def repository
    CustomCacheModel
  end
end
