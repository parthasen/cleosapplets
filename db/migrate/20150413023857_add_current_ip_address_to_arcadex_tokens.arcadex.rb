# This migration comes from arcadex (originally 20140910215118)
class AddCurrentIpAddressToArcadexTokens < ActiveRecord::Migration
  def change
    add_column :arcadex_tokens, :current_ip_address, :string
  end
end
