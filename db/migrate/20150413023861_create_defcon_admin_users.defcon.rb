# This migration comes from defcon (originally 20141008173352)
class CreateDefconAdminUsers < ActiveRecord::Migration
  def change
    create_table :defcon_admin_users do |t|
      t.string :username
      t.string :password_digest
      t.boolean :read_only
      t.integer :attempts
      t.integer :max_attempts
      t.boolean :master
      t.integer :priority

      t.timestamps
    end
  end
end
