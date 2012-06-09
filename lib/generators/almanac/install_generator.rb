require "rails/generators/migration"
require "rails/generators/active_record"

module Almanac
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      desc "Copy Almanac migrations."
      source_root File.expand_path("../templates", __FILE__)

      def copy_migrations
        migration_template "create_almanac.rb", "db/migrate/create_almanac.rb"
      end

      def self.next_migration_number(*args)
        ActiveRecord::Generators::Base.next_migration_number(*args)
      end
    end
  end
end