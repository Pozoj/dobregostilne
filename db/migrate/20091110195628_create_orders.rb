class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders, :force => true do |t|
      t.string :company_name
      t.string :person_name
      t.string :address
      t.integer :post_id
      t.integer :vat_id
      t.string :phone
      t.string :mobile
      t.string :fax
      t.string :email
      t.integer :quantity
      t.string :ip_address
      t.datetime :date_processed

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
