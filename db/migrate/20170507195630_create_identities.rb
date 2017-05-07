class CreateIdentities < ActiveRecord::Migration[5.1]
  # rails g model identity user:references provider:string accesstoken:string uid:string name:string email:string nickname:string image:string phone:string urls:string'

  def change
    create_table :identities do |t|
      t.references :user, foreign_key: true
      t.string :provider
      t.string :accesstoken
      t.string :refreshtoken
      t.string :uid
      t.string :name
      t.string :email
      t.string :nickname
      t.string :image
      t.string :phone
      t.string :urls

      t.timestamps
    end
  end
end