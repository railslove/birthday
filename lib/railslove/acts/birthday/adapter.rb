# Birthday
module Railslove
  module Acts #:nodoc:
    module Birthday #:nodoc:
      module Adapter
        autoload Mysql2Adapter
        autoload PostgreSQLAdapter
        
        def self.adapter_for(connection)
          "Railslove::Acts::Birthday::Adapter::#{connection.class.name.demodulize}".constantize
        end
        
      end
    end
  end
end