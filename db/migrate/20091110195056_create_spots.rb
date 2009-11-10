class CreateSpots < ActiveRecord::Migration
  def self.up
    create_table :spots, :force => true do |t|
      t.integer :type_id
      t.string :name
      t.string :long_name
      t.string :name_websafe
      t.integer :category
      t.integer :large_post_id
      t.integer :post_id
      t.integer :locality_id
      t.string :street
      t.integer :street_number
      t.string :street_number_suffix
      t.string :phone
      t.string :fax
      t.string :mobile
      t.string :email
      t.string :website
      t.integer :cuisine_id
      t.boolean :has_garden, :default => false
      t.boolean :has_homebread, :default => false
      t.boolean :has_rooms, :default => false
      t.integer :number_of_1_rooms, :default => 0
      t.integer :number_of_2_rooms, :default => 0
      t.integer :number_of_3_rooms, :default => 0
      t.integer :number_of_4_rooms, :default => 0
      t.integer :number_of_appartments, :default => 0
      t.integer :number_of_disabled_rooms, :default => 0
      t.integer :number_of_executive_rooms, :default => 0

      t.string :contact_name
      t.string :contact_phone
      t.string :contact_vat
      t.string :notes      
      
      t.integer :default_image
      

      t.timestamps
    end
  end

  def self.down
    drop_table :spots
  end
end
