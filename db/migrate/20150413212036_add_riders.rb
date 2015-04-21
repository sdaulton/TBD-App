class AddRiders < ActiveRecord::Migration
  def change
    add_column :riders, :user_id, :integer
    add_column :users, :is_rider, :boolean
    add_column :users, :is_driver, :boolean
    add_column :users, :driver_license, :string
    add_column :users, :driver_license_state, :string
    add_column :users, :license_plate, :string
    add_column :users, :license_plate_state, :string
    add_column :users, :make, :string
    add_column :users, :model, :string
    add_column :users, :year, :integer
  end
end
