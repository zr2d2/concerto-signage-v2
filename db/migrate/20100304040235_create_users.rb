class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :name
      t.string :email
      t.text :greeting
      t.string :image
      t.string :website

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
