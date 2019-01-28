class DropTableCategory < ActiveRecord::Migration[5.2]
  def change
  	drop_table :categories
  end
end
