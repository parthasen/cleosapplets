# This migration comes from arcadex (originally 20141020173616)
class AddMaxUsesToArcadexTokens < ActiveRecord::Migration
  def change
    add_column :arcadex_tokens, :max_uses, :integer
  end
end
