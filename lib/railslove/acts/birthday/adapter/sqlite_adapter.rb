module Railslove
  module Acts
    module Birthday
      module Adapter
        class SQLiteAdapter
          def self.scope_hash(field, date_start, date_end)
            date_start = date_start.to_date
            if ((date_end.respond_to?(:empty?) && date_end.empty?) || !date_end)
              where_sql = "strftime('%m%d', `#{field}`) = \"#{date_start.strftime('%m%d')}\""
            else
              date_end = date_end.to_date
              if date_end.strftime('%m%d') < date_start.strftime('%m%d')
                where_sql = "(strftime('%m%d', `#{field}`) >= \"0101\""
                where_sql << " AND strftime('%m%d', `#{field}`) <= \"#{date_end.strftime('%m%d')}\")"
                where_sql << " OR (strftime('%m%d', `#{field}`) >= \"#{date_start.strftime('%m%d')}\""
                where_sql << " AND strftime('%m%d', `#{field}`) <= \"1231\")"
              else
                where_sql = "strftime('%m%d', `#{field}`) >= \"#{date_start.strftime('%m%d')}\" AND strftime('%m%d', `#{field}`) <= \"#{date_end.strftime('%m%d')}\""
              end
            end
            { :conditions => where_sql }
          end
        end
      end
    end
  end
end