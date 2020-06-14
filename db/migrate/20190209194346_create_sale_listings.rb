class CreateSaleListings < ActiveRecord::Migration[5.2]
  def change
    create_table :sale_listings do |t|
      t.uuid :uuid, default: -> { "gen_random_uuid()" }
      t.string :reference, index: true
      t.integer  :flags, default: 0, null: false, index: true

      # booleans used in scopes
      t.boolean :furnished, default: false
      # t.boolean :sold, default: false
      t.boolean :reserved, default: false
      t.boolean :highlighted, default: false, index: true
      t.boolean :archived, default: false
      # when above is set to true, below needs to be set to false
      t.boolean :visible, default: false, index: true

      t.boolean :hide_map, default: false
      t.boolean :obscure_map, default: false

      # t.datetime :available_from
      # t.datetime :available_till
      # t.integer :occupants, index: true
      # t.integer :units, index: true
      t.string :main_video_url
      t.json :details
      # t.string :area_search_key
      t.datetime :publish_from
      t.datetime :publish_till
      # t.integer :listing_asset_id
      t.integer :realty_asset_id
      # t.jsonb :locale_content
      # below for mobility:
      t.jsonb :translations, default: {}
      # and discarded gem:
      t.datetime :discarded_at, index: true

      # t.monetize :price_rental_monthly_current
      # t.monetize :price_rental_monthly_original
      t.monetize :price_sale_current
      t.monetize :price_sale_original
      t.monetize :commission
      t.monetize :service_charge_yearly

      t.string   :currency
      t.string :import_url
      t.json :related_urls, default: {}
      t.string :project_uuid
      t.timestamps
    end

    add_index :sale_listings, :price_sale_current_cents
    add_index :sale_listings, :price_sale_original_cents

  end
end
