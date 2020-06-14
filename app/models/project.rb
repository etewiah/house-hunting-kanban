class Project < ApplicationRecord
  has_many :rental_listings, foreign_key: "project_uuid"
  has_many :sale_listings, foreign_key: "project_uuid"
  has_many :rental_listing_with_assets, foreign_key: "project_uuid"
  has_many :sale_listing_with_assets, foreign_key: "project_uuid"

  include Discard::Model
  extend Mobility
  mob_translates :slug, :title, :description, :title_meta
  # , :description, :description_meta, :description_summary

end
