# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ly = "
探してた鍵を　今　見つけた
心拍数は　遥か雲まで越えてゆく

風が揺らす　あの娘のスカートの向こう
蜃気楼に　僕らの夏が消えてゆく

願いだ　もうちょっと　時よ　待ってよ
造りかけのパズル　あとひとかけらで揃いそうなんだ

つかめない　駆けてく光の中　広がる世界　まだ眩しすぎて
報われない　空の果てまで　だって僕らは　ずっと未完成のまま

探してた鍵を　今　見つけた
心拍数は　遥か雲まで越えてゆく

風が揺らす　あの娘のスカートの向こう
蜃気楼に　僕らの夏が消えてゆく

願いだ　もうちょっと　時よ　待ってよ
造りかけのパズル　あとひとかけらで揃いそうなんだ

つかめない　駆けてく光の中　広がる世界　まだ眩しすぎて
報われない　空の果てまで　だって僕らは　ずっと未完成のまま

探してた鍵を　今　見つけた
心拍数は　遥か雲まで越えてゆく

風が揺らす　あの娘のスカートの向こう
蜃気楼に　僕らの夏が消えてゆく

願いだ　もうちょっと　時よ　待ってよ
造りかけのパズル　あとひとかけらで揃いそうなんだ

つかめない　駆けてく光の中　広がる世界　まだ眩しすぎて
報われない　空の果てまで　だって僕らは　ずっと未完成のまま
"

(1..100).each do |number|
  user = User.new(name: 'TEST-USER-' + number.to_s, email: 'test' + number.to_s + '@exam.com', profile: "Hello", password: 'testpass', password_confirmation: 'testpass')  
  user.save
  lyric = user.lyrics.new(title: "Halation", content: ly, comment: "熱い思いをこめました")
  lyric.save
end