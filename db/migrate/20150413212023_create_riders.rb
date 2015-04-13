class CreateRiders < ActiveRecord::Migration
  def change
    create_table :riders do |t|

      t.timestamps null: false
    end
  end
end
