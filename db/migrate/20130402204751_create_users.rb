class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.string :last_ip
      t.boolean :is_admin
      t.string :email_confirmation_token
      t.string :reset_password_token
      t.string :locale
      t.string :auth_token

      t.timestamps
    end
  end
end
