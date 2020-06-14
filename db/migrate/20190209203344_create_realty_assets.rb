class CreateRealtyAssets < ActiveRecord::Migration[5.2]
  def change
    create_table :realty_assets do |t|
      t.uuid :uuid, default: -> { "gen_random_uuid()" }
      t.string   :reference, index: true
      t.string   :title
      t.text     :description

      t.integer  :year_construction, default: 0, null: false
      t.integer  :count_bedrooms, default: 0, null: false, index: true
      t.float  :count_bathrooms, default: 0, null: false, index: true
      # turns out count_bathrooms in the US can be .5, 1.5 etc
      # so might need a float for above
      t.integer  :count_toilets, default: 0, null: false, index: true
      t.integer  :count_garages, default: 0, null: false, index: true
      t.float    :plot_area, default: 0, null: false, index: true
      t.float    :constructed_area, default: 0, null: false, index: true
      t.integer :area_unit, default: 0

      t.integer  :energy_rating
      t.float    :energy_performance

      t.integer  :flags, default: 0, null: false

      t.string :prop_origin_key, default: "", null: false
      t.string :prop_state_key, default: "", null: false
      t.string :prop_type_key, default: "", null: false

      t.string :street_number
      t.string :street_name
      t.string :street_address
      t.string :postal_code
      t.string :province
      t.string :city
      # below will save a cityname without accents etc
      t.string :city_search_key, default: "", null: false, index: true
      t.string :region
      t.string :country
      t.float :latitude
      t.float :longitude
      # t.integer :occupants, default: 1, index: true
      # t.integer :units, default: 1, index: true
      t.string :floor
      # t.string :main_video_url
      # other video_urls
      t.json :details, default: {}

      t.string :neighborhood
      # below will save a hood without accents etc
      t.string :neighborhood_search_key, default: "", null: false, index: true
      # below acts as a kind of reference when I'm importing so I can 
      # search for previously imported items per url
      t.string :import_url
      # t.json :related_urls, default: {}
      t.string :google_place_id

      # below for mobility:
      t.jsonb :translations, default: {}
      t.jsonb :categories, default: {}
      t.timestamps
    end
    add_index  :realty_assets, :categories, using: :gin
    # https://github.com/alexreisner/geocoder
    add_index :realty_assets, [:latitude, :longitude]

  end
end
