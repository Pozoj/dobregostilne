class CreateLocalities < ActiveRecord::Migration
  def self.up
    create_table :localities, :force => true do |t|
      t.string :name
      t.integer :post_id      

      t.timestamps
    end
  end

  def self.down
    drop_table :localities
  end
end
