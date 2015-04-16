class AddAccountTypeToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_driver, :boolean
    add_column :users, :is_rider, :boolean
  end
end
