module MarshalingAssertions
  class DummyObject
    attr_reader :x, :y

    def initialize(x:, y:)
      @x = x
      @y = y
    end

    def cache_key
      "#{@x}/#{@y}"
    end
  end

  def dummy_object
    DummyObject.new(x: 1, y: 'test')
  end

  def test_caching_objects
    cache.fetch(dummy_object.cache_key) do
      dummy_object
    end

    object = cache.read(dummy_object.cache_key)
    assert_equal 1, object.x
    assert_equal 'test', object.y
  end

  def test_cache_large_objects
    cache.fetch(dummy_object.cache_key) do
      'x' * 300
    end

    result = cache.read(dummy_object.cache_key)
    assert_equal 300, result.length
  end
end
