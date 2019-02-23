class Users < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :profile_url
      t.string :password_digest
    end
  end
end
