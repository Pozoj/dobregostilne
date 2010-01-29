class AddImageToPayments < ActiveRecord::Migration
  def self.up
    add_column :payments, :image, :boolean, :default => true
  end

  def self.down
    remove_column :payments, :image
  end
end
