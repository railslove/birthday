# Birthday
module Railslove
  module Acts #:nodoc:
    module Birthday #:nodoc:
      def self.included(base)
        base.extend ClassMethods  
      end

      module ClassMethods
        def acts_as_birthday(*args)
          birthday_fields = args.to_a.flatten.compact.map(&:to_sym)

          if ["ActiveRecord::ConnectionAdapters::Mysql2Adapter","ActiveRecord::ConnectionAdapters::MysqlAdapter"].include?(ActiveRecord::Base.connection.class.name)
            birthday_fields.each do |field|
              class_eval %{
                def self.find_#{field.to_s.pluralize}_for(date_start, date_end = nil)
                  date_start = date_start.to_date
                  unless date_end
                    where_sql = "DATE_FORMAT(`#{field}`, '%m%d') = \\"\#{date_start.strftime('%m%d')}\\""
                  else
                    date_end = date_end.to_date
                    if date_end.strftime('%m%d') < date_start.strftime('%m%d')
                      where_sql = "(DATE_FORMAT(`#{field}`, '%m%d') >= \\"0101\\""
                      where_sql << " AND DATE_FORMAT(`#{field}`, '%m%d') <= \\"\#{date_start.strftime('%m%d')}\\")"
                      where_sql << " OR (DATE_FORMAT(`#{field}`, '%m%d') >= \\"\#{date_end.strftime('%m%d')}\\""
                      where_sql << " AND DATE_FORMAT(`#{field}`, '%m%d') <= \\"1231\\")"
                    else
                      where_sql = "DATE_FORMAT(`#{field}`, '%m%d') >= \\"\#{date_start.strftime('%m%d')}\\" AND DATE_FORMAT(`#{field}`, '%m%d') <= \\"\#{date_end.strftime('%m%d')}\\""
                    end
                  end
                  self.find(:all, :conditions => where_sql)
                end
              }
            end
          elsif ActiveRecord::Base.connection.class.name == "ActiveRecord::ConnectionAdapters::PostgreSQLAdapter"
            birthday_fields.each do |field|
              class_eval %{
                def self.find_#{field.to_s.pluralize}_for(date_start, date_end = nil)
                  date_start = date_start.to_date
                  unless date_end
                    where_sql = "to_char(\\"#{field}\\", 'MMDD') = '\#{date_start.strftime('%m%d')}'"
                  else
                    date_end = date_end.to_date
                    if date_end.strftime('%m%d') < date_start.strftime('%m%d')
                      where_sql = "to_char(\\"#{field}\\", 'MMDD') BETWEEN '0101' AND '\#{date_end.strftime('%m%d')}'"
                      where_sql << "OR to_char(\\"#{field}\\", 'MMDD') BETWEEN '\#{date_start.strftime('%m%d')}' AND '1231'"
                    else
                      where_sql = "to_char(\\"#{field}\\", 'MMDD') BETWEEN '\#{date_start.strftime('%m%d')}' AND '\#{date_end.strftime('%m%d')}'"
                    end
                  end
                  self.find(:all, :conditions => where_sql)
                end
              }
            end
          else
            raise "acts_as_birthday gem does not support databases other than PostgreSQL and MySQL at this time!"
          end

          birthday_fields.each do |field|
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