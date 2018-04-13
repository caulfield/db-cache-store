module CacheAssertions
  def test_presence
    assert cache
  end

  def test_read_write_scenario
    cache.write 1, 42
    assert_equal 42, cache.read(1)

    db_item = repository.find_by(key: 1)
    refute db_item.deleted_at
    refute db_item.expired_at
  end

  def test_expiration_scenario
    cache.write 1, 42, expires_in: -1.day
    assert_nil cache.read(1)
    refute cache.exist?(1)

    db_item = repository.find_by(key: 1)
    assert db_item.expired_at
    refute db_item.deleted_at
  end

  def test_value_overwrite
    cache.write 1, 42, expires_in: 1.day
    cache.write 1, 43, expires_in: 2.day

    assert_equal 43, cache.read(1)
    assert_equal 42, cache.read(1, version: 1)
    assert_equal 43, cache.read(1, version: 2)

    db_item = repository.find_by(key: 1, version: 1)
    refute db_item.expired_at
    refute db_item.deleted_at

    second_db_item = repository.find_by(key: 1, version: 2)
    refute second_db_item.expired_at
    refute second_db_item.deleted_at
  end

  def test_expired_value_overwrite
    cache.write 1, 42, expires_in: -1.day
    assert_nil cache.read(1)

    cache.write 1, 43, expires_in: 1.day
    assert_equal 43, cache.read(1)
  end

  def test_expired_at_ignore
    cache.write 1, 42, expires_in: 1.day
    assert_equal 42, cache.read(1)

    db_record = repository.find_by(key: 1)
    refute db_record.expired_at?
  end

  def test_cleanup
    cache.write 1, 42, expires_in: -1.day
    cache.write 2, 42, expires_in: 1.day

    cache.read 1
    cache.read 2
    cache.cleanup

    assert_equal 1, repository.where(deleted_at: nil).count
    assert_equal 2, repository.count
  end

  def test_clear
    cache.write 1, 42
    cache.write 1, 43
    cache.write 2, 44

    cache.clear

    refute cache.read(1)
    refute cache.read(2)
  end

  def test_namespace
    cache.write 1, 42, namespace: 'test'
    assert_equal 42, cache.read('test:1')
    assert_equal 42, cache.read('1', namespace: 'test')
  end

  def test_delete
    cache.write 1, 42
    cache.delete 1

    refute cache.read(1)

    db_item = repository.find_by(key: 1)
    assert db_item.expired_at?
    refute db_item.deleted_at?
  end

  def test_fetch_without_options
    cache.fetch(1) do
      42
    end
    cache.fetch(1) do
      refute true
    end
    assert_equal 42, cache.read(1)
  end

  def test_fetch_with_force_option
    cache.fetch(1) do
      42
    end
    cache.fetch(1, force: true) do
      43
    end
    assert_equal 43, cache.read(1)
  end
end
