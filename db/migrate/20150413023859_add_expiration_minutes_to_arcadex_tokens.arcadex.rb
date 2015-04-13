# This migration comes from arcadex (originally 20140910215147)
class AddExpirationMinutesToArcadexTokens < ActiveRecord::Migration
  def change
    add_column :arcadex_tokens, :expiration_minutes, :integer
  end
end
