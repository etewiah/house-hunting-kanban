class SaleListing < ApplicationRecord
  include Discard::Model
  extend Mobility
  mob_translates :slug, :title, :title_summary, :title_meta, :description, :description_meta, :description_summary
  # , touch: true

  belongs_to :realty_asset
  belongs_to :project, foreign_key: "project_uuid", optional: true
  has_many :listing_photos, -> { order 'sort_order asc' }, class_name: "SaleListingPhoto", foreign_key: 'sale_listing_id'
  # has_many :features, class_name: "FeatureRef", foreign_key: 'sale_listing_id'
  has_many :notes, class_name: "Note", foreign_key: 'sale_listing_id'

  # Getter
  def get_features
    Hash[features.map { |key, _value| [key.feature_key, true] }]
    # http://stackoverflow.com/questions/39567/what-is-the-best-way-to-convert-an-array-to-a-hash-in-ruby
    # returns something like {"terraza"=>true, "alarma"=>true, "gotele"=>true, "sueloMarmol"=>true}
    # - much easier to use on the client side admin page
  end

  # Setter- called by update_extras in properties controller
  # expects a hash with keys like "cl.casafactory.fieldLabels.extras.alarma"
  # each with a value of true or false
  def set_features=(features_json)
    # return unless features_json.class == Hash
    features_json.keys.each do |feature_key|
      # TODO - create feature_key if its missing
      if features_json[feature_key] == "true" || features_json[feature_key] == true
        features.find_or_create_by( ref_slug: feature_key)
      else
        features.where( ref_slug: feature_key).delete_all
      end
    end
  end

  def features_list
    # used by vue admin to list features
    features.map { |key, _value| key.ref_slug }
    # Hash[features.map { |key, _value| [key.feature_key, true] }]
  end

  def self.class_mob_atts
    # for strong params in controller
    exp_mob_attr_names = []
    # Website.unique_instance.supported_locales_short.each do |locale|
    I18n.available_locales.each do |locale|
      SaleListing.mobility_attributes.each do |attr|
        exp_mob_attr_names.push "#{attr}_#{locale}"
      end
    end
    exp_mob_attr_names
  end
end
