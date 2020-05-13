class AddComentsToRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :comments, :text
  end
end
