# This migration comes from arcadex (originally 20140806194834)
class CreateArcadexTokens < ActiveRecord::Migration
  def change
    create_table :arcadex_tokens do |t|
      t.integer :imageable_id
      t.string :imageable_type
      t.string :auth_token

      t.timestamps
    end
  end
end
