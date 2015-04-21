class AddRiders < ActiveRecord::Migration
  def change
    add_column :riders, :user_id, :integer
  end
end
