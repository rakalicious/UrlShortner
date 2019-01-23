class CreateDomains < ActiveRecord::Migration[5.2]
  def change
    create_table :domains do |t|
    	t.text :domain_name
      t.string :short_domain

      t.timestampsr
    end
  end
end
