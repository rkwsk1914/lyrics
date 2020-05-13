class RemoveMusicdataFromRequests < ActiveRecord::Migration[5.2]
  def change
    remove_column :requests, :musicdata, :string
  end
end
