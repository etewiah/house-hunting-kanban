class CreateGuests < ActiveRecord::Migration[6.0]
  def change
    create_table :guests do |t|
      t.uuid :uuid, default: -> { "gen_random_uuid()" }
      t.uuid :authentication_token, default: -> { "gen_random_uuid()" }

      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''

      t.string :first_names
      t.string :last_names

      t.timestamps null: false
    end
  end
end
