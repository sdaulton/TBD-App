class AddDrivers < ActiveRecord::Migration
  def change
    add_column :drivers, :user_id, :integer
  end
end
