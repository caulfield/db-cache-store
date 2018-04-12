# frozen_string_literal: true

require 'test_helper'

module ArCacheStore
  class VersionTest < Minitest::Test
    def test_version_exist
      refute_nil ::ArCacheStore::VERSION
    end
  end
end
