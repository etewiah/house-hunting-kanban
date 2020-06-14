class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.uuid :uuid, default: -> { "gen_random_uuid()" }
      t.string :project_uuid
      t.integer  :flags, default: 0, null: false, index: true
      t.integer :sale_listing_id
      t.integer :rental_listing_id
      # t.integer :listing_id
      t.integer :user_id
      t.string :title
      t.json :details, default: {}

      t.jsonb :translations, default: {}
      # and discarded gem:
      t.datetime :discarded_at, index: true

      t.timestamps
    end
  end
end
