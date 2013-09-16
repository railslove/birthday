# Birthday
module Railslove
  module Acts #:nodoc:
    module Birthday #:nodoc:
      autoload :Adapter, 'railslove/acts/birthday/adapter'

      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods

        # Expects an array of date or datetime fields.
        # An example code in basic model would be:
        #
        #   class Person < ActiveRecord::Base
        #     acts_as_birthday :birthday, :created_at
        #   end
        #
        # This will create scopes:
        #   Person.find_birthdays_for
        #   Person.find_created_ats_for
        # and instance methods:
        #   person = Person.find(1)
        #   person.birthday_age => 34
        #   person.birthday_today? => true/false
        #   person.created_at_age => 2
        #   person.created_at_today? => true/false
        def acts_as_birthday(*birthday_fields)

          scope_method = ActiveRecord::VERSION::MAJOR >= 3 ? 'scope' : 'named_scope'

          birthday_fields.each do |field|
            self.send(scope_method, :"find_#{field.to_s.pluralize}_for", lambda{ |*scope_args|
              raise ArgumentError if scope_args.empty? or scope_args.size > 2
              date_start, date_end = *scope_args
              where ::Railslove::Acts::Birthday::Adapter.adapter_for(self.connection).scope_hash(field, date_start, date_end)[:conditions]
            })

            self.send(scope_method, :"#{field.to_s}_today", lambda{ self.send(:"find_#{field.to_s.pluralize}_for", Date.today) })

            class_eval %{
              def #{field}_age
                return nil unless self.#{field}?
                today = Date.today
                age = today.year - #{field}.year
                age -= 1 if today.month < #{field}.month || (today.month == #{field}.month && today.mday < #{field}.mday)
                age
              end

              def #{field}_today?
                return nil unless self.#{field}?
                Date.today.strftime('%m%d') == #{field}.strftime('%m%d')
              end
            }
          end
        end
      end

    end
  end
end
