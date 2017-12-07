# Birthday
module Railslove
  module Acts #:nodoc:
    module Birthday #:nodoc:
      module Adapter
        autoload :MysqlAdapter, 'railslove/acts/birthday/adapter/mysql_adapter'
        autoload :Mysql2Adapter, 'railslove/acts/birthday/adapter/mysql2_adapter'
        autoload :PostgreSQLAdapter, 'railslove/acts/birthday/adapter/postgresql_adapter'
        autoload :MakaraPostgreSQLAdapter, 'railslove/acts/birthday/adapter/makara_postgresql_adapter'
        autoload :SQLite3Adapter, 'railslove/acts/birthday/adapter/sqlite3_adapter'

        def self.adapter_for(connection)
          "Railslove::Acts::Birthday::Adapter::#{connection.class.name.demodulize}".constantize
        end

      end
    end
  end
end
