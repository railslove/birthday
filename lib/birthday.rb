require "railslove/acts/birthday/birthday"
require "railslove/acts/birthday/version"

ActiveRecord::Base.send :include, ::Railslove::Acts::Birthday