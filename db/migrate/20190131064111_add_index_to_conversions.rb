class AddIndexToConversions < ActiveRecord::Migration[5.2]
  def change
  	  add_index :conversions , :date , :unique => true
  end
end
