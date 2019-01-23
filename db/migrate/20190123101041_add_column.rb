class AddColumn < ActiveRecord::Migration[5.2]
  def change
  	add_column :urls , :short_domain, :string
  end
end
