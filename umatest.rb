
# 文字列と数値変換 https://qiita.com/kikkutonton/items/3421cceba1543237b804
# 文字化け https://qiita.com/foloinfo/items/435f0409a6e33929ef3c
# xpath詳しい https://blog.takuros.net/entry/2014/04/15/070434
# せいき表現 https://hfuji.hatenablog.jp/entry/2015/11/04/175606

require 'nokogiri'
require 'open-uri'
require 'kconv'
require 'csv'


url1 = 'https://db.netkeiba.com/horse/ped/'
url2 = 'https://db.netkeiba.com/horse/'

inturl = 2015104923


#inturl = 2015100000
CSV.open("umatest2.csv", "w") do |csv|
    
20.times do
  
    strurl = inturl.to_s
    puts strurl
    
    uri = url1 + strurl

    html = open(uri, "r:binary").read
    doc = Nokogiri::HTML(html.toutf8, nil, 'utf-8')
            
    docc = doc.title
    
    
     
    unless docc.match(/^の.*/) #or docc.match(/.*[0-9]{4}.*/)  #ない馬は登録されない　重賞出生率は欲しい？
        doc2 = docc.gsub('の血統表 | 競走馬データ - netkeiba.com','')
    else
        doc2 =''
    end
    
    puts doc2
    
         
    uri = url2 + strurl

    html = open(uri, "r:binary").read
    doc = Nokogiri::HTML(html.toutf8, nil, 'utf-8')
    
    doca = doc.to_s
    doca =~ /成績">(.+)<\/a>/
    result = $+
   
    puts result

    
    #uma = Uma.new(umaid: strurl , name: doc2 , umarecord: result)
    #uma.save

    
    csv << [strurl,doc2,result]
    
    inturl = strurl.to_i
    inturl += 1
    
    end
end