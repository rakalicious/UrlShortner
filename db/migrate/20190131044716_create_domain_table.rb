class CreateDomainTable < ActiveRecord::Migration[5.2]
  def change
    create_table :domain_tables do |t|
    	t.string :domain_name
    	t.string :short_domain
    	      t.timestamps
    end
  end
end
