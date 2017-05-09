class CreateUserTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :user_tokens do |t|
      t.belongs_to :user, foreign_key: true
      t.string :access_token

      t.timestamps
    end
  end
end
