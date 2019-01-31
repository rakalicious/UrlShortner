class DropUrlTable < ActiveRecord::Migration[5.2]
  def change
  	  	drop_table :url_tables

  end
end
