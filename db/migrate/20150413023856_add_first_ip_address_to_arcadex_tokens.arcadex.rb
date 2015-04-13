# This migration comes from arcadex (originally 20140910215044)
class AddFirstIpAddressToArcadexTokens < ActiveRecord::Migration
  def change
    add_column :arcadex_tokens, :first_ip_address, :string
  end
end
