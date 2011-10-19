require "railslove/acts/birthday/birthday"
require "railslove/acts/birthday/adapters/mysql_adapter"
require "railslove/acts/birthday/adapters/mysql2_adapter"
require "railslove/acts/birthday/adapters/postgresql_adapter"
require "railslove/acts/birthday/version"

ActiveRecord::Base.send :include, ::Railslove::Acts::Birthday