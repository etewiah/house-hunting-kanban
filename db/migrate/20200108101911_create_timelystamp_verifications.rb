class CreateTimelystampVerifications < ActiveRecord::Migration[6.0]
  def change
    create_table :timelystamp_verifications do |t|
      t.uuid :uuid, default: -> { "gen_random_uuid()" }
      t.integer :flags, default: 0, null: false, index: true
      t.string :timelystamp_url_hash, index: true
      t.text :body
      t.string :body_sha256, index: true
      t.text :whole_page
      t.string :whole_page_sha256 #, index: true
      t.datetime :timestamped_at
      t.timestamps
    end
  end
end
