require 'rails/generators/migration'

module Census
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    source_root File.expand_path("../templates", __FILE__)

    def self.next_migration_number(path)
      unless @prev_migration_nr
        @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
      else
        @prev_migration_nr += 1
      end
      @prev_migration_nr.to_s
    end

    def add_to_user
      user_model = "/app/models/user.rb"
      if File.exists?(user_model)
        inject_into_class user_model, "User" do
          "include Census::User\n"
        end unless File.readlines(user_model).grep(/include Census::User/).size > 0
      else
        directory File.join("app", "models")
        file "user.rb", user_model
      end
    end
    desc "Copies a config initializer to config/initializers/census.rb"
    def copy_files
      copy_file 'census.rb', 'config/initializers/census.rb'
    end

    def migration
      if ActiveRecord::Base.connection.table_exists?(:users)
        migration_template "migrations/without_users.rb", "db/migrate/create_census_tables.rb"
      else
        migration_template "migrations/with_users.rb", "db/migrate/create_census_tables.rb"
      end
    end
  end
end