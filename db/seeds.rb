# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

cc =  "
そばにいたいよ　きみのためにできることが　ぼくにあるかな　いつもきみに　ずっときみに　わらっていてほしくて
そばにいたいよ　きみのためにできることが　ぼくにあるかな　いつもきみに　ずっときみに　わらっていてほしくて
そばにいたいよ　きみのためにできることが　ぼくにあるかな　いつもきみに　ずっときみに　わらっていてほしくて
そばにいたいよ　きみのためにできることが　ぼくにあるかな　いつもきみに　ずっときみに　わらっていてほしくて
そばにいたいよ　きみのためにできることが　ぼくにあるかな　いつもきみに　ずっときみに　わらっていてほしくて
そばにいたいよ　きみのためにできることが　ぼくにあるかな　いつもきみに　ずっときみに　わらっていてほしくて
そばにいたいよ　きみのためにできることが　ぼくにあるかな　いつもきみに　ずっときみに　わらっていてほしくて
そばにいたいよ　きみのためにできることが　ぼくにあるかな　いつもきみに　ずっときみに　わらっていてほしくて
そばにいたいよ　きみのためにできることが　ぼくにあるかな　いつもきみに　ずっときみに　わらっていてほしくて
そばにいたいよ　きみのためにできることが　ぼくにあるかな　いつもきみに　ずっときみに　わらっていてほしくて
そばにいたいよ　きみのためにできることが　ぼくにあるかな　いつもきみに　ずっときみに　わらっていてほしくて
そばにいたいよ　きみのためにできることが　ぼくにあるかな　いつもきみに　ずっときみに　わらっていてほしくて
そばにいたいよ　きみのためにできることが　ぼくにあるかな　いつもきみに　ずっときみに　わらっていてほしくて
そばにいたいよ　きみのためにできることが　ぼくにあるかな　いつもきみに　ずっときみに　わらっていてほしくて
"

(1..100).each do |number|
  Lyric.create(title: 'test title ' + number.to_s, content: cc, comment: 'test case', user_id: number)
  User.create(name: 'TEST-USER-' + number.to_s, email: 'test' + number.to_s + '@exam.com', password: '12345678', password_confirmation: '12345678',)
end