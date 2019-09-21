
# 文字列と数値変換 https://qiita.com/kikkutonton/items/3421cceba1543237b804
# 文字化け https://qiita.com/foloinfo/items/435f0409a6e33929ef3c
# xpath詳しい https://blog.takuros.net/entry/2014/04/15/070434
# せいき表現 https://hfuji.hatenablog.jp/entry/2015/11/04/175606
# 詳しい　http://otn.hatenablog.jp/entry/20090509/p1

require 'nokogiri'
require 'open-uri'
require 'kconv'
require 'csv'


url1 = 'https://db.netkeiba.com/horse/ped/'
url2 = 'https://db.netkeiba.com/horse/'

#inturl = 2015104793
inturl = 2015105000
#inturl = 2015100000


CSV.open("umatest2.csv", "w") do |csv|
    
200.times do
  
    strurl = inturl.to_s
    puts strurl
    
    uri = url1 + strurl

    html = open(uri, "r:binary").read
    doc = Nokogiri::HTML(html.toutf8, nil, 'utf-8')
            
    docc = doc.title
    
     
    unless docc.match(/^の.*/)  #or docc.match(/.*[0-9]{4}.*/)  #ない馬は登録されない　重賞出生率は欲しい？
        umaname = docc.gsub('の血統表 | 競走馬データ - netkeiba.com','')
    else
        umaname =''
    end
    
    
    unless umaname == ""    
    puts umaname
    

    
# 血統のページを文字にして、改行などを削除。    
    
     ped = doc.to_s 
     pped = ped.gsub(/\r\n|\r|\s|\t/, "").gsub(/<spanclass="red">/, "") # 改行などを削除<spanclass="red">も後から取れなかったので削除

     #pped =~ /rowspan="\d{2}"class="b_ml"><ahref="\/horse\/\w*\/">(.+?)<br>/

# 血統表の馬名のみ抽出。finpedに配列で入る。
     
     finped =  pped.scan(/rowspan="\d{,2}"class="b_\w{,3}"><ahref="\/horse\/\w*\/">(.+?)</)
  #   scanメソッドなので finped に配列でパターンマッチするところが全部入る
   #  p finped # 確認用
   #  puts finped # 確認用だと取得したいデータに見える
    
   
     
  # puts pped.scan(/rowspan="\d{,2}"class=(.+?)ml"/)
     #r = $+
     #puts r

# 馬のトップメージをスクレイピング
         
    uri = url2 + strurl

    html = open(uri, "r:binary").read
    doc = Nokogiri::HTML(html.toutf8, nil, 'utf-8')
    
    docrecord = doc.to_s 
    
# 成績を取得
    docrecord =~ /競走成績">(.+?)<\/a>/ 
    result = $+
   
    result =~ /^(.+?)-/
    win = $+.to_i 
    
    result =~ /^\d{,2}-(.+?)-/
    second = $+.to_i 
    
    result =~ /^\d{,2}-\d{,2}-(.+?)-/  
    third = $+.to_i   
    
    result =~ /^\d{,2}-\d{,2}-\d{,2}-(.+)$/ 
    other = $+.to_i  

    all = win+second+third+other
    
    
# 重賞出走回数
    dd =  doc.xpath('//table[@class="db_h_race_results nk_tb_common"]').text
  #  puts dd
    grace = dd.scan(/(G\d)/).size 
    #puts grace
    
#  性別   
     sex = doc.xpath('//p[@class="txt_01"]').text
        #puts sex
    if sex.include?("牝")
        sex = 'hinba'
    else
        sex = 'boba'
    end
   
    #puts sex
     

    
# 馬のトップページから、改行などを削除。     
    top  = doc.to_s.gsub(/\r\n|\r|\s|\t/, "")
    top =~  (/獲得賞金<\/th><td>(.+?)万円/)
  #  rows = doc.xpath('//td[@id="owner_info_td"]').text
    umatop =  $+ 
    money = umatop.gsub(/,/, "").gsub(/億/, "").to_i* 10000
    
    
    # 誕生日取る
    
    top =~  (/生年月日<\/th><td>(.+?)</)
    birth = $+
    birthday = Date.strptime(birth,'%Y年%m月%d日') # 型を変換
  
    
    # 重賞勝利歴 1はあり
  #  docrec = doc.to_s.gsub(/\r\n|\r|\s|\t/, "")
    top =~ /主な勝鞍.*?">(.+?)<\/a>/ 
    mainwin = $+
    
    gracewin = mainwin.scan(/(G\d)/).size 
    
    

    
# csv書き込み umaname がカラの場合は書き込みしない。
    
    
        #csv << [strurl,doc2,result]
        csv << [strurl,umaname,sex,birthday,all,win,second,third,other,money,grace,gracewin,finped] #csv書き込み finpedの配列をダブルクオートと[] を削除して書き込みできない
        # csv
    end # unless umanameに対応
    
# 次の馬へ    
    inturl = strurl.to_i
    inturl += 1
    
    end
end