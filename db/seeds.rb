# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#紐付けたいのであれば、
#uma = Uma.create!(
#などとして、
#uma.create_umaline!(
#Umaline.create!( の部分を↑に代えてやってみてください

# 実行コマンド rails db:seed

require 'csv'

CSV.read("uma.csv").each do |row|
  
    uma = Uma.create!(
    horse_id: row[0],
    horse_name: row[1],
    sex: row[2],
    birthday: row[3],
    all: row[4],
    win: row[5],
    second: row[6],
    third: row[7],
    other: row[8],
    money: row[9],
    gwin: row[11],
    ghistory: row[10]
  )

  
    uma.create_umaline(
    ml: row[12],
    ml2: row[13],
    ml3_1: row[14]

  )
  
end

puts 'done'