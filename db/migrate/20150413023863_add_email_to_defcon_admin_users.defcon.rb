# This migration comes from defcon (originally 20141009215910)
class AddEmailToDefconAdminUsers < ActiveRecord::Migration
  def change
    add_column :defcon_admin_users, :email, :string
    add_index :defcon_admin_users, :email, unique: true
  end
end
