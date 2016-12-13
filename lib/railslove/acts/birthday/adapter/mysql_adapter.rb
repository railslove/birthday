# Birthday
module Railslove
  module Acts #:nodoc:
    module Birthday #:nodoc:
      module Adapter
        class MysqlAdapter
          def self.scope_hash(field, date_start, date_end)
            date_start = date_start.to_date
            if ((date_end.respond_to?(:empty?) && date_end.empty?) || !date_end)
              where_sql = "DATE_FORMAT(#{field}, '%m%d') = \"#{date_start.strftime('%m%d')}\""
            else
              date_end = date_end.to_date
              if date_end.strftime('%m%d') < date_start.strftime('%m%d')
                where_sql = "(DATE_FORMAT(#{field}, '%m%d') >= \"0101\""
                where_sql << " AND DATE_FORMAT(#{field}, '%m%d') <= \"#{date_end.strftime('%m%d')}\")"
                where_sql << " OR (DATE_FORMAT(#{field}, '%m%d') >= \"#{date_start.strftime('%m%d')}\""
                where_sql << " AND DATE_FORMAT(#{field}, '%m%d') <= \"1231\")"
              else
                where_sql = "DATE_FORMAT(#{field}, '%m%d') >= \"#{date_start.strftime('%m%d')}\" AND DATE_FORMAT(#{field}, '%m%d') <= \"#{date_end.strftime('%m%d')}\""
              end
            end
            { :conditions => where_sql }
          end
        end
      end
    end
  end
end
