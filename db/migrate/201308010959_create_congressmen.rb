require_relative '../config'

# this is where you should use an ActiveRecord migration to 

class CreateCongressmen < ActiveRecord::Migration
  def change
    # HINT: checkout ActiveRecord::Migration.create_table
    create_table :congressmen do |t|
      t.string :title
      t.string :firstname
      t.string :middlename
      t.string :lastname
      t.string :name_suffix
      t.string :nickname
      t.integer :party_id
      t.string :state
      t.string :district
      t.string :in_office
      t.string :gender
      t.string :phone
      t.string :fax
      t.string :website
      t.string :webform
      t.string :congress_office
      t.integer :bioguide_id
      t.integer :votesmart_id
      t.integer :fec_id
      t.integer :govtrack_id
      t.integer :crp_id
      t.string :twitter_id
      t.string :congresspedia_url
      t.string :youtube_url
      t.string :facebook_id
      t.string :official_rss
      t.string :senate_class
      t.date :birthdate
    end
  end
end

