class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t| # only need to specify a primary key when we don't want one / need to change
                              # Rails automatically creates a primary key for our table
    	t.column "first_name", :string, :limit => 25
      t.string "last_name", :limit => 50
      t.string "email", :default => "", :null => false
      t.string "password", :limit => 40

      # t.datetime "created_at"
      # t.datetime "updated_at"
      t.timestamps null: false

    end
  end

  def down
  	drop_table :users
  end
end
