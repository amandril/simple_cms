class CreateSections < ActiveRecord::Migration
  
  def change
  	create_table :sections do |s|
  		s.integer "page_id"
  		# same as: s.references: page
  		s.string "name"
  		s.integer "position"
  		s.boolean "visible", :default => false
  		s.string "content_type"
  		s.text "content"
  		s.timestamps
  	end
  	add_index("sections", "page_id")
  end

end
