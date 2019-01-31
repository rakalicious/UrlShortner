class CreateUrlTable < ActiveRecord::Migration[5.2]
  def change
    create_table :url_tables do |t|
    	t.text :long_url
      t.string :short_url

      t.timestamps
    end
  end
end
