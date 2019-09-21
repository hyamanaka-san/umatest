
require 'csv'

CSV.open("uma.csv", "w") do |csv|
    
r = File.read("umatest2.csv").gsub(/\[|\]|\"/,"") #"とか[とかを削除"
rr = r.gsub(/\,\s/,"\,")


csv << [rr]

end

p 'done check uma.csv'
