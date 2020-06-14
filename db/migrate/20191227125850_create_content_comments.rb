class CreateContentComments < ActiveRecord::Migration[6.0]
  def change
    create_table :content_comments do |t|
      t.uuid :uuid, default: -> { "gen_random_uuid()" }
      t.integer :flags, default: 0, null: false, index: true
      t.datetime :discarded_at
      t.uuid :guest_uuid
      t.uuid :access_token_uuid
      t.uuid :user_uuid
      t.uuid :content_uuid
      t.text :raw
      t.text :cooked
      t.timestamps
    end
  end
end
