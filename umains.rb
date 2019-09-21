# インポート https://qiita.com/SoarTec-lab/items/50e046ea2a2764c12c21

require 'csv'

CSV.open("umatest2.csv",headers: true).each do |row|
  p row 
  

end

