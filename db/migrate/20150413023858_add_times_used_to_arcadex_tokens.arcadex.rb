# This migration comes from arcadex (originally 20140910215136)
class AddTimesUsedToArcadexTokens < ActiveRecord::Migration
  def change
    add_column :arcadex_tokens, :times_used, :integer
  end
end
