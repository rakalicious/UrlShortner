class CreateConversion < ActiveRecord::Migration[5.2]
  def change
    create_table :conversions do |t|
    	t.date :date
      t.integer :count
      t.timestamps
    end
  end
end
