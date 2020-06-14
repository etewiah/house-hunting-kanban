class CreateRentalListingPhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :rental_listing_photos do |t|
      t.uuid :uuid, default: -> { "gen_random_uuid()" }
      t.integer :rental_listing_id, index: true
      t.string :image
      t.string :description
      t.string :folder, default: "weebrix"
      t.integer :file_size
      t.json :process_options, default: {} 
      t.string :height
      t.string :width
      t.string :content_type
      t.integer :sort_order

      # below for mobility:
      t.jsonb :translations, default: {}
      t.timestamps null: false
    end
  end
end