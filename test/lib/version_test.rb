# frozen_string_literal: true

require 'test_helper'

module DbCacheStore
  class VersionTest < Minitest::Test
    def test_version_exist
      refute_nil ::DbCacheStore::VERSION
    end
  end
end
