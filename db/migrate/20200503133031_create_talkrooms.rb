class CreateTalkrooms < ActiveRecord::Migration[5.2]
  def change
    create_table :talkrooms do |t|
      t.references :user, foreign_key: true
      t.references :roommate, foreign_key: { to_table: :users }

      t.timestamps
      
       t.index [:user_id, :roommate_id], unique: true
    end
  end
end
