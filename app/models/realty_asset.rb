class RealtyAsset < ApplicationRecord
  include Discard::Model
  has_many :rental_listings
  has_many :sale_listings
  # , foreign_key: :listing_asset_id
  # todo - change listing_asset_id to realty_asset_id
  # , class_name: "Feature", foreign_key: 'prop_id'
end
