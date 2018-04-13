# frozen_string_literal: true

class DbCacheStoreCreate<%= table_name.camelize %> < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :<%= table_name %>, id: false do |t|
      t.string :key
      t.text :entry
      t.integer :version, default: 1

      t.datetime :expired_at
      t.datetime :deleted_at
    end

    add_index :<%= table_name %>, :expired_at
    add_index :<%= table_name %>, :deleted_at
    add_index :<%= table_name %>, :key
  end
end
