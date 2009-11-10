class CreateSpotPaymentsJoinTable < ActiveRecord::Migration
  def self.up
    create_table :payments_spots, :force => true, :id => false do |t|
      t.integer :payment_id
      t.integer :spot_id
    end
  end

  def self.down
    drop_table :payments_spots
  end
end
