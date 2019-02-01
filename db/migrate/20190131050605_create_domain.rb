class CreateDomain < ActiveRecord::Migration[5.2]
  def change
    create_table :domains do |t|
    	t.string :domain_name
    	t.string :short_domain
    	      t.timestamps
    end
  end
end
