class AddTalkroomToMessages < ActiveRecord::Migration[5.2]
  def change
    add_reference :messages, :talkroom, foreign_key: true
  end
end
