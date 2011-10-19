# Birthday
module Railslove
  module Acts #:nodoc:
    module Birthday #:nodoc:
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods

        # Expects an array of date or datetime fields. If the first object
        # in passed array is a class with a class method `scope_hash`
        #   class SqliteAdapter
        #     def self.scope_hash(field, date_start, date_end)
        #       # do some magic and return scope hash you can use
        #     end
        #   end
        # 
        # then this class is used as an adapter to create its scope for birthday finders.
        #
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
        def acts_as_birthday(*args)
          args = args.to_a.flatten.compact
          klass = args.shift if args.first.class == Class
          if klass && klass.class == Class
            @@_birthday_backend = klass
          else
            @@_birthday_backend ||= "Railslove::Acts::Birthday::Adapters::#{ActiveRecord::Base.connection.class.name.split("::").last}".constantize
          end
          
          birthday_fields = args.map(&:to_sym)

          scope_method = ActiveRecord::VERSION::MAJOR == 3 ? 'scope' : 'named_scope'

          self.send(scope_method, :_birthday, lambda do |*scope_args|
            raise ArgumentError if scope_args.empty? or scope_args.size > 3
            field, date_start, date_end = scope_args
            @@_birthday_backend.scope_hash(field, date_start, date_end)
          end)

          birthday_fields.each do |field|
            self.send(scope_method, :"find_#{field.to_s.pluralize}_for", lambda{ |*specific_scope_args| _birthday(field, *specific_scope_args) })

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