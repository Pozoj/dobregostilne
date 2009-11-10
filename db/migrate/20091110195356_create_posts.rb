class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts, :force => true do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
