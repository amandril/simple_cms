class CreateSubjects < ActiveRecord::Migration
  
  def up
  	create_table :subjects do |s|
  		s.string "name"
  		s.integer "position"
  		s.boolean "visible", :default => false
      
      s.timestamps
  	end
  end
  
  def down
  	drop_table :subjects
  end

end
