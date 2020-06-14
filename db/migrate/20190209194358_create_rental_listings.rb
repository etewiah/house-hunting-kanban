class CreateRentalListings < ActiveRecord::Migration[5.2]
  def change
    create_table :rental_listings do |t|
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

      t.boolean :for_rent_daily, default: false, index: true
      t.boolean :for_rent_monthly, default: false, index: true
      t.boolean :for_rent_long_term, default: false, index: true
      # if I used flag shih tzu for above, I couldn't make queries like:
      # Property.where('for_rent_daily_term OR for_rent_long_term')

      t.boolean :hide_map, default: false
      t.boolean :obscure_map, default: false

      t.datetime :available_from
      t.datetime :available_till
      t.integer :occupants, index: true
      t.integer :units, index: true
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
      t.monetize :price_rental_monthly_low_season
      t.monetize :price_rental_monthly_high_season
      t.monetize :price_rental_monthly_standard_season
      t.monetize :price_rental_daily_low_season
      t.monetize :price_rental_daily_high_season
      t.monetize :price_rental_daily_standard_season
      t.monetize :commission
      t.monetize :service_charge_yearly

      # below is the lowest of the 3 seasonal monthly values
      # or the standard rental value
      # needed to allow me to search across diff rental types
      t.monetize :price_rental_monthly_for_search
      t.monetize :price_rental_daily_for_search

      t.string   :currency
      t.string :import_url
      t.json :related_urls, default: {}
      # below 2 for
      # https://github.com/tandusrl/acts_as_bookable
      t.integer :capacity
      t.text :schedule
      t.string :project_uuid
      t.timestamps
    end

    # may 2018 - currently using standard_season prices rather than below
    # might make use of them later:
    add_index :rental_listings, :price_rental_monthly_for_search_cents
    add_index :rental_listings, :price_rental_daily_for_search_cents

  end
end
