class CreateConversionTable < ActiveRecord::Migration[5.2]
  def change
    create_table :conversion_tables do |t|
    	t.date :date
      t.integer :count
      t.timestamps
    end
  end
end
