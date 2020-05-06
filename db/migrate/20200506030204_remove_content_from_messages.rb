class RemoveContentFromMessages < ActiveRecord::Migration[5.2]
  def change
    remove_column :messages, :content, :string
  end
end
