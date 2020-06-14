# very similar to content model
class CreateTimelystamps < ActiveRecord::Migration[6.0]
  def change
    create_table :timelystamps do |t|
      # instead of having user or guest ids here to denote ownership
      # I'm using access_tokens
      t.uuid :uuid, default: -> { "gen_random_uuid()" }
      t.integer :flags, default: 0, null: false, index: true
      t.integer :status, default: 0, null: false, index: true
      t.integer :views_count, default: 0, null: false

      t.boolean :is_private, default: false
      t.boolean :is_secured, default: false
      t.boolean :is_published, default: false

      t.integer :anon_access_level, default: 0, null: false
      t.integer :anon_edit_role, default: 0, null: false

      t.text :body
      t.string :body_sha256, index: true
      t.text :whole_page
      t.string :whole_page_sha256 #, index: true
      t.json :details, default: {}

      t.string :url_without_query
      # Jan 2020 above not currently in use
      t.string :url
      t.string :url_sha256, index: true
      # thinking about using below for a sha256 that includes a timestamp....
      t.string :url_with_ts_sha256, index: true
      t.string :slug
      t.text :description
      t.string :title
      # t.string :sha1, null: false, default: ''
      # t.string :sha1
      t.string :other_hash
      t.integer :other_hash_type, default: 0

      t.datetime :timestamped_at

      t.datetime :visible_from
      t.datetime :visible_till
      t.datetime :to_destroy_at
      t.datetime :to_discard_at
      t.datetime :discarded_at
      t.timestamps
    end
  end
end
