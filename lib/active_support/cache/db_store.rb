require 'active_support/cache'
require 'active_support/cache/db_item'

module ActiveSupport
  module Cache
    class DbStore < Store
      attr_reader :repository

      def initialize(options = {})
        super(options)
        @repository = options.fetch(:repository, DbItem)
      end

      def clear(options = {})
        @repository.update_all(deleted_at: Time.now)
      end

      def cleanup(options = {})
        @repository.where.not(expired_at: nil).update_all(deleted_at: Time.now)
      end

      private

      def read_entry(key, options = {})
        scope = @repository.where(expired_at: nil).where(deleted_at: nil).order(version: :desc)
        if options[:version]
          scope = scope.where(version: options[:version])
        end
        scope.find_by(key: key)
      end

      def write_entry(key, entry, options = nil)
        @repository.create \
          key: key,
          entry: YAML.dump(entry),
          version: (read_entry(key, options)&.version.to_f + 1)
      end

      def delete_entry(key, options = nil)
        read_entry(key)&.touch(:expired_at)
      end
    end
  end
end
