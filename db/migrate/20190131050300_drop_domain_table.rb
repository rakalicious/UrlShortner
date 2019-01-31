class DropDomainTable < ActiveRecord::Migration[5.2]
  def change
  	  	drop_table :domain_tables

  end
end
