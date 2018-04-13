# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'pry'
require 'minitest/autorun'

require './lib/db_cache_store'

ActiveRecord::Base.logger = nil

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

ActiveRecord::Schema.define do
  create_table ActiveSupport::Cache::DbItem::TABLE_NAME do |table|
    table.string :key
    table.text :entry
    table.integer :version, default: 1

    table.datetime :expired_at
    table.datetime :deleted_at
  end

  create_table 'custom_caches' do |table|
    table.string :key
    table.text :entry
    table.integer :version, default: 1

    table.datetime :expired_at
    table.datetime :deleted_at
  end
end

class CustomCacheModel < ActiveSupport::Cache::DbItem
  self.table_name = 'custom_caches'
end
