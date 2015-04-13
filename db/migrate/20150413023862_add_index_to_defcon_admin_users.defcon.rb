# This migration comes from defcon (originally 20141008214632)
class AddIndexToDefconAdminUsers < ActiveRecord::Migration
  def change
    add_index :defcon_admin_users, :username, unique: true
  end
end
