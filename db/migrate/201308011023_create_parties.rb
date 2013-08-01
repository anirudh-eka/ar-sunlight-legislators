require_relative '../config'

# this is where you should use an ActiveRecord migration to 

class CreateParties < ActiveRecord::Migration
  def change
    # HINT: checkout ActiveRecord::Migration.create_table
    create_table :parties do |t| 
      t.string :name
    end
  end
end
