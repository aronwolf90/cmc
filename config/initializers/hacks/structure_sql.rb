# frozen_string_literal: true

module ActiveRecord
  module Tasks # :nodoc:
    class PostgreSQLDatabaseTasks # :nodoc:
      def structure_dump(filename, extra_flags)
        set_psql_env

        search_path = Organization.find_by(name: "test-organization")&.name
        if search_path.nil?
          Rails.logger.warn("Schema is not auto dumped when test-organization is no present")
          puts "[WARN] Schema is not auto dumped when test-organization is no present"
        end

        args = ["-s", "-x", "-O", "-f", filename]
        args.concat(Array(extra_flags)) if extra_flags
        if search_path.present?
          args += search_path.split(",").map do |part|
            "--schema=#{part.strip}"
          end
        end

        ignore_tables = ActiveRecord::SchemaDumper.ignore_tables
        if ignore_tables.any?
          args += ignore_tables.flat_map { |table| ["-T", table] }
        end

        args << configuration["database"]
        run_cmd("pg_dump", args, "dumping")
        remove_sql_header_comments(filename)

        result = File.read(filename)
                     .gsub('"test-organization".', "")
                     .gsub('"test-organization"', "")
                     .gsub("CREATE SCHEMA ;\n", "")
                     .gsub("SELECT pg_catalog.set_config('search_path', '', false);\n", "")
        File.write(filename, result)
      end
    end
  end
end
