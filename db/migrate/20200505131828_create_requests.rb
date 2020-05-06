class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.references :user, foreign_key: true
      t.references :lyric, foreign_key: true
      t.boolean :permission

      t.timestamps
    end
  end
end
