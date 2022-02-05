class AddDatetimesToAccessToken < ActiveRecord::Migration[7.0]
  def change
    add_column :access_tokens, :approved_at, :datetime
    add_column :access_tokens, :revoked_at, :datetime
    add_column :access_tokens, :last_access_at, :datetime
  end
end
