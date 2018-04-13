require 'active_record'

module ActiveSupport
  module Cache
    class DbItem < ActiveRecord::Base
      TABLE_NAME = 'db_cache_store_items'

      self.table_name = TABLE_NAME

      def entry
        serialized_value = attributes['entry']
        YAML.load(serialized_value) if serialized_value
      end

      def value
        entry.value
      end

      def expired?
        entry.expired?
      end
    end
  end
end
