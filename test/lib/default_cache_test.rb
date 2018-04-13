require 'test_helper'
require 'cache_assertions'
require 'marshaling_assertions'

class DefaultCacheTest < Minitest::Test
  include CacheAssertions
  include MarshalingAssertions

  def cache
    ActiveSupport::Cache.lookup_store(:db_store)
  end

  def setup
    repository.delete_all
  end

  def repository
    ActiveSupport::Cache::DbItem
  end
end
