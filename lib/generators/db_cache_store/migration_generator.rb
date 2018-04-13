require 'rails/generators/base'

module DbCacheStore
  module Generators
    class MigrationGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      argument :table_name, type: :string, default: ActiveSupport::Cache::DbItem::TABLE_NAME

      desc "Generates a migration for given TABLE to use it as cache storage."

      source_root File.expand_path("../templates", __FILE__)

      def generate_migration
        migration_template "migration.rb", "db/migrate/db_cache_store_create_#{table_name}.rb"
      end

      def migration_version
        "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
      end

      def self.next_migration_number(dir)
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      end
    end
  end
end
