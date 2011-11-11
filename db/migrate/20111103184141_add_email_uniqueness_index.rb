class AddEmailUniquenessIndex < ActiveRecord::Migration
  def self.up
    # add index to the users table for :email which is unique
    # an index is like a book index, so for this email, it will point to the 
    # record containing it and it can only point one place

    add_index :users, :email, :unique =>true
  end

  def self.down
    remove_index :users, :email
  end
end
