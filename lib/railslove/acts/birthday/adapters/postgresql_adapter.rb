# Birthday
module Railslove
  module Acts #:nodoc:
    module Birthday #:nodoc:
      module Adapters
        class PostgreSQLAdapter
          def initialize(field, date_start, date_end)
            date_start = date_start.to_date
            if ((date_end.respond_to?(:empty?) && date_end.empty?) || !date_end)
              where_sql = "to_char(\"#{field}\", 'MMDD') = '#{date_start.strftime('%m%d')}'"
            else
              date_end = date_end.to_date
              if date_end.strftime('%m%d') < date_start.strftime('%m%d')
                where_sql = "to_char(\"#{field}\", 'MMDD') BETWEEN '0101' AND '#{date_end.strftime('%m%d')}'"
                where_sql << "OR to_char(\"#{field}\", 'MMDD') BETWEEN '#{date_start.strftime('%m%d')}' AND '1231'"
              else
                where_sql = "to_char(\"#{field}\", 'MMDD') BETWEEN '#{date_start.strftime('%m%d')}' AND '#{date_end.strftime('%m%d')}'"
              end
            end
            { :conditions => where_sql }
          end
        end
      end
    end
  end
end