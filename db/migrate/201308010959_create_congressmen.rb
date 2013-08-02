require_relative '../config'
# this is where you should use an ActiveRecord migration to 

class CreateCongressmen < ActiveRecord::Migration
  def change
    # HINT: checkout ActiveRecord::Migration.create_table
    create_table :congressmen do |t|
      t.string :title
      t.string :name
      t.string :last_name
      t.belongs_to :party
      t.string :state
      t.boolean :in_office
      t.string :gender
      t.string :phone
      t.string :fax
      t.string :website
      t.string :webform
      t.string :twitter_id
      t.date :birthdate
    end
  end
end

