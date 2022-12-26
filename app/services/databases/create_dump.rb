# frozen_string_literal: true

module Databases
  class CreateDump
    attr_reader :database_dump

    def call
      backup_database
      return unless success?

      upload_file_to_s3
      remove_local_backup
    end

    def success?
      @success
    end

    private

    # restore database:
    #   rake db:drop db:create
    #   gunzip tmp/#{backup_filename}.gz | psql -U db_config['user'] -d db_config['database'] -f tmp/#{backup_filename}
    def backup_database
      @success = system("pg_dump #{database_atts} | gzip -9 > #{store_path}/#{backup_filename}.psql.gz")
    end

    def upload_file_to_s3
      @database_dump = DatabaseDump.create!(file: Rails.root.join("#{store_path}/#{backup_filename}.psql.gz").open)
    end

    def remove_local_backup
      File.delete("#{store_path}/#{backup_filename}.psql.gz") if File.exist?("#{store_path}/#{backup_filename}.psql.gz")
    end

    def database_atts
      "--dbname=postgresql://#{db_config['user']}:#{db_config['password']}@#{host}:#{port}/#{db_config['database']} --verbose --clean --no-owner --format=p --no-acl"
    end

    def host
      return db_config['host'] if ['staging', 'production'].include?(environment)

      'localhost'
    end

    def port
      return db_config['port'] if ['staging', 'production'].include?(environment)

      '5432'
    end

    def db_config
      @db_config ||= ActiveRecord::Base.configurations[environment]
    end

    def store_path
      'tmp'
    end

    def environment
      @environment ||= Rails.env
    end

    def datestamp
      Time.now.strftime('%Y-%m-%d_%H-%M-%S')
    end

    def backup_filename
      @backup_filename ||= "#{Rails.root.basename}-#{datestamp}"
    end
  end
end
