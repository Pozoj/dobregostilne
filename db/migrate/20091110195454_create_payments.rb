class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments, :force => true do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :payments
  end
end
