# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create(email: "admin@admin",password: "adminadmin")
Customer.create(last_name:"姓",first_name:"名",last_name_kana:"セイ",first_name_kana:"メイ",email:"customer@customer",password:"customer",postal_code:"0000000",address:"tokyo",telephone_number:"00000000000")
genres = Genre.create([{name: "ケーキ"}, {name: "プリン"}, {name: "焼き菓子"}, {name: "キャンディ"}])
