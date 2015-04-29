class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.integer :user_r_id
      t.integer :user_d_id
      t.string :start_location
      t.string :end_location
      t.boolean :driver_at_pickup
      t.boolean :rider_pickup_confirm
      t.boolean :driver_pickup_confirm
      t.boolean :rider_dropoff_confirm
      t.string :driver_dropoff_confirm

      t.timestamps null: false
    end
  end
end
