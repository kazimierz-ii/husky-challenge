class CreateAccessTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :access_tokens do |t|
      t.references :user, null: false, foreign_key: true
      t.string :token
      t.string :status, limit: 1

      t.timestamps
    end

    add_index :access_tokens, :status
  end
end
