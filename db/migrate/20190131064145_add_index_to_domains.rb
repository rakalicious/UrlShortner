class AddIndexToDomains < ActiveRecord::Migration[5.2]
  def change
	add_index :domains , :domain_name , :unique => true
	add_index :domains , :short_domain , :unique => true
  end
end
