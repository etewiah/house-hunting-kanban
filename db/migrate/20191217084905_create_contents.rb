class CreateContents < ActiveRecord::Migration[6.0]
  def change
    create_table :contents do |t|
      t.uuid :uuid, default: -> { "gen_random_uuid()" }
      # Jan 2020 - authentication_token below not really used
      t.uuid :authentication_token, default: -> { "gen_random_uuid()" }
      t.integer :flags, default: 0, null: false, index: true
      t.integer :status, default: 0, null: false, index: true
      t.integer :views_count, default: 0, null: false

      t.boolean :is_private, default: false
      t.boolean :is_secured, default: false
      t.boolean :is_published, default: false

      t.integer :anon_access_level, default: 0, null: false, index: true
      t.integer :anon_edit_role, default: 0, null: false, index: true

      t.text :raw
      t.text :cooked

      t.string :url
      t.string :slug
      t.text :description
      t.string :title
      # t.string :sha1, null: false, default: ''
      t.string :sha1
      t.string :sha256
      t.string :other_hash
      t.integer :other_hash_type, default: 0

      t.datetime :visible_from
      t.datetime :visible_till
      t.datetime :to_destroy_at
      t.datetime :to_discard_at
      t.datetime :discarded_at
      # t.timestamps null: false
      t.timestamps
    end
  end
end
