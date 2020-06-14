# Scenic View!
# -- rails generate scenic:view sale_listing_with_asset
# or better:
# -- rails generate scenic:model sale_listing_with_asset
class SaleListingWithAsset < ApplicationRecord
  include Discard::Model
  extend Mobility
  mob_translates :slug, :title, :title_summary, :title_meta, :description, :description_meta, :description_summary, default: ""

  self.primary_key = :id

  # this isn't strictly necessary, but it will prevent
  # rails from calling save, which would fail anyway.
  def readonly?
    true
  end

  belongs_to :project, foreign_key: "project_uuid"

  # monetize :price_rental_daily_for_search_cents, with_model_currency: :currency

  # monetize :commission_cents, with_model_currency: :currency
  monetize :service_charge_yearly_cents, with_model_currency: :currency
  # monetize :price_in_a_range_cents, with_model_currency: :currency, :allow_nil => true,
  # :numericality => {
  #   :greater_than_or_equal_to => 0,
  #   :less_than_or_equal_to => 10000
  # }

  # TODO: - Ensure admin client can warn of uniqueness errors
  # and enable below:
  # validates :reference, :uniqueness => { case_sensitive: false }

  has_many :listing_photos, -> { order "sort_order asc" }, class_name: "SaleListingPhoto", foreign_key: "sale_listing_id"
  # has_many :features, class_name: "FeatureRef", foreign_key: 'sale_listing_id'
  has_many :notes, class_name: "Note", foreign_key: "sale_listing_id"

  # june 2018 - TODO - have a join similar to above for restrictions (eg - no pets, no smoking)
  # or perhaps add a flag to features such as "is_restriction"

  # scope :for_rent, -> () { where('for_rent_short_term OR for_rent_long_term') }
  # couldn't do above if for_rent_short_term was a flatshihtzu boolean
  # scope :for_rent_daily, -> () { where for_rent_daily: true }
  # scope :for_rent_monthly, -> () { where for_rent_monthly: true }
  scope :visible, ->() { where visible: true }

  # scope :has_feature, ->(feature_key) { joins(:features).merge(Feature.where(feature_key: "features.#{feature_key}"))}
  # TODO - perhaps force feature_key in Feature model to be always lowercase
  # -as of aug 2018, only features.airCon is not all lowercase.
  # Not worth all this hassle because of a few cases....
  scope :has_feature, ->(feature_key) { joins(:features).merge(Feature.where("lower(feature_key) =?", "features.#{feature_key}".downcase)) }

  # TODO - figure out if transliterate below might be slowing things down:
  scope :in_city, ->(city) { where("lower(city_search_key) =?", I18n.transliterate(city).downcase) }
  # .where('lower(name) = ?', name.downcase).first
  # scope :property_type, ->(property_type) { where prop_type_key: property_type }
  # scope :property_state, ->(property_state) { where prop_state_key: property_state }
  # scope :property_type_without_prefix, ->(property_type) { where prop_type_key: "propertyTypes.#{property_type}" }
  # scope :property_state_without_prefix, ->(property_state) { where prop_state_key: "propertyStates.#{property_state}" }

  # below scopes used for searching
  # scope :for_rent_price_monthly_from, ->(minimum_price) { where("price_rental_monthly_standard_season_cents >= ?", minimum_price.to_s) }
  # scope :for_rent_price_monthly_till, ->(maximum_price) { where("price_rental_monthly_standard_season_cents <= ?", maximum_price.to_s) }
  # scope :for_rent_price_daily_from, ->(minimum_price) { where("price_rental_daily_standard_season_cents >= ?", minimum_price.to_s) }
  # scope :for_rent_price_daily_till, ->(maximum_price) { where("price_rental_daily_standard_season_cents <= ?", maximum_price.to_s) }
  scope :for_sale_price_from, ->(minimum_price) { where("price_sale_current_cents >= ?", minimum_price.to_s) }
  scope :for_sale_price_till, ->(maximum_price) { where("price_sale_current_cents <= ?", maximum_price.to_s) }

  scope :count_bathrooms_from, ->(min_count_bathrooms) { where("count_bathrooms >= ?", min_count_bathrooms.to_s) }
  scope :count_bathrooms_till, ->(max_count_bathrooms) { where("count_bathrooms <= ?", max_count_bathrooms.to_s) }
  scope :count_bedrooms_from, ->(min_count_bedrooms) { where("count_bedrooms >= ?", min_count_bedrooms.to_s) }
  scope :count_bedrooms_till, ->(max_count_bedrooms) { where("count_bedrooms <= ?", max_count_bedrooms.to_s) }
  # scope :occupants_from, ->(min_occupants) { where("occupants >= ?", min_occupants.to_s) }
  # scope :occupants_till, ->(max_occupants) { where("occupants <= ?", max_occupants.to_s) }

  # below is cheating/laziness - should really just add a migration 
  # to the scenic view to include the uuid
  belongs_to :sale_listing, foreign_key: "id"
  def uuid
    return sale_listing.uuid
  end

  def image_urls
    related_urls["images"] || []
  end

  def primary_image_url
    if listing_photos.length > 0
      listing_photos[0].image.url
    else
      ""
    end
  end

  def image_details
    image_details = []
    listing_photos.each do |photo|
      details = {
        alt_text: photo.alt_text,
        sort_order: photo.sort_order,
        std: {
          url: photo.image.url,
        # in future might add desc etc
        },
        small_fill: {
          url: photo.image.small_fill.url,
        },
        small_fit: {
          url: photo.image.small_fit.url,
        },
      # thumb_fill: {
      #   url: photo.image.thumb_fill.url
      # },
      # thumb_fit: {
      #   url: photo.image.thumb_fit.url
      # }
      }
      image_details.push details
    end
    return image_details
  end

  def features_list
    # used by vue admin to list features
    features.map { |key, _value| key.ref_slug }
    # Hash[features.map { |key, _value| [key.ref_slug, true] }]
  end

  def listing_id
    # needed when updating realty_asset location etc
    self.id
  end

  def listing_model
    # has to be plural to match with routing endpoints
    "sale_listings"
  end

  def mob_atts
    exp_mob_attr_names = []
    # Website.unique_instance.supported_locales_short.each do |locale|
    I18n.available_locales.each do |locale|
      # byebug
      # self.i18n.mobility_attributes.each do |attr|
      # self.mobility_attributes.each do |attr|
      # for above get error:
      # undefined method `mobility_attributes' for #<SaleListingWithAsset:0x00007fcb19de1a98>
      SaleListingWithAsset.mobility_attributes.each do |attr|
        exp_mob_attr_names.push "#{attr}_#{locale}"
      end
    end
    exp_mob_attr_names
  end
end
