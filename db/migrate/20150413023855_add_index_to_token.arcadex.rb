# This migration comes from arcadex (originally 20140806202340)
class AddIndexToToken < ActiveRecord::Migration
  def change
  	add_index :arcadex_tokens, :auth_token, unique: true
  end
end
