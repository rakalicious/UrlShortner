class DropUserTable < ActiveRecord::Migration[5.2]
  def change
  	drop_table :user_tables
  end
end
