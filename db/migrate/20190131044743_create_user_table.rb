class CreateUserTable < ActiveRecord::Migration[5.2]
  def change
    create_table :user_tables do |t|
    	t.string :username
      t.string :password
      t.string :name
      t.string :email
      t.timestamps
    end

  end
end
