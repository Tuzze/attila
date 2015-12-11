module Attila

class DataTranslator
   def load(connection, table, valid_time)
     q = connection.query("SELECT * FROM #{table} ORDER BY #{valid_time} ASC")
     res = { table:[], attributes: {} }
     q.each do |r|
      row = {values:{}, vt: DateTime.parse(r[valid_time.to_s]).to_time }
      values, attributes =row[:values], res[:attributes]
      r.delete(valid_time.to_s)
       r.each do |k,v|
         if v.nil?
           values[k.to_sym] = 0
         else
          attributes[k.to_sym].nil? ? attributes[k.to_sym] = {} : true
          if attributes[k.to_sym][v].nil?
              values[k.to_sym] = attributes[k.to_sym][v] = attributes[k.to_sym].size + 1
          else
              values[k.to_sym] = attributes[k.to_sym][v]
          end
         end
       end
       res[:table].push(row)
     end
     res
   end
end

end