class AddMusicdataToRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :musicdata, :string
  end
end
