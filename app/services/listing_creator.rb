class ListingCreator
  attr_accessor :enable_geocode, :features_locales, :current_locale, :max_photos_to_process

  def initialize(**keyword_args)
    # https://www.justinweiss.com/articles/fun-with-keyword-arguments/
    # self.listing_hash = listing_hash
    self.enable_geocode = keyword_args["enable_geocode"] || keyword_args[:enable_geocode] || false
    self.features_locales = keyword_args["features_locales"] || keyword_args[:features_locales] || ["en", "es"]
    self.current_locale = keyword_args["current_locale"] || keyword_args[:current_locale] || "en"
    self.max_photos_to_process = keyword_args["max_photos_to_process"] || keyword_args[:max_photos_to_process] || 2
  end

  # TODO: move logic for below (currently in prop model) to here:
  # before_save :set_rental_search_price
  # after_create :set_defaults

  def create_from_hash(listing_hash)
    I18n.locale = current_locale
    # set correct locale so that globalise fields are correct

    new_asset_params = listing_hash.slice(
      "reference",
      "floor",
      "import_url",
      "country",
      "area_unit",
      "count_bedrooms", "count_bathrooms", "latitude", "longitude",
      # "title", "description",
      "postal_code", "street_address"
    )
    new_asset = RealtyAsset.create(new_asset_params)

    if listing_hash["for_sale"]
      new_listing_params = listing_hash.slice(
        "reference",
        "import_url",
        "occupants", "units",
        "main_video_url", "currency",
        # "price_sale_current_cents",
        # "for_rent_monthly", "for_rent_daily", "for_rent_long_term",
        "title_summary", "description_summary",
        "title_meta", "description_meta",
        "title", "description",
      )
      new_listing = new_asset.sale_listings.create(new_listing_params)
      if listing_hash["price_float"].is_a? Float
        new_listing.price_sale_current_cents = listing_hash["price_float"] * 100
      end
    else
      new_listing_params = listing_hash.slice(
        "reference",
        "occupants", "units",
        "import_url",
        # "country",
        # "area_unit",
        "main_video_url", "currency",
        # "price_rental_daily_standard_season_cents",
        "for_rent_monthly", "for_rent_daily", "for_rent_long_term",
        # "count_bedrooms", "count_bathrooms", "latitude", "longitude",
        "title_summary", "description_summary",
        "title_meta", "description_meta",
        "title", "description",
        # "postal_code", "street_address"
      )
      new_listing = new_asset.rental_listings.create(new_listing_params)
      if listing_hash["price_float"].is_a? Float
        new_listing.price_rental_monthly_standard_season_cents = listing_hash["price_float"] * 100
      end
    end

    # // This value will only be correct when parsing an es url:
    # new_listing_params["slug"] = listing_hash["slug_es"]
    # es_slug = listing_hash["slug_es"]
    # new_listing.set_localized_slug("es", es_slug)

    if enable_geocode
      if listing_hash["latitude"] && listing_hash["longitude"]
        unless listing_hash["street_address"] && listing_hash["postal_code"]
          new_asset.reverse_geocode
        end
      else
        new_asset.geocode
      end
    end

    if listing_hash["area_unit"]
      new_asset.area_unit = listing_hash["area_unit"]
    end

    # create will use website defaults for currency and area_unit
    # need to override that
    if listing_hash["currency"]
      new_listing.currency = listing_hash["currency"]
    end

    if listing_hash["features"]
      # new_listing.set_features=listing_hash["features"]
      listing_hash["features"].each do |feature_name|
        feature_translation_model = I18n::Backend::ActiveRecord::Translation.find_by_value(feature_name.strip)
        if feature_translation_model
          feature_key = feature_translation_model.key
        else
          feature_key = "features." + feature_name.camelize(:lower).delete(" \t\r\n")
          features_locales.each do |locale|
            # not much I can do other than set all features_locales to the translation I know of
            # Admin can go in later and edit them
            I18n::Backend::ActiveRecord::Translation.create!(
              { locale: locale, key: feature_key, value: feature_name.strip }
            )
          end
        end
        new_listing.features.find_or_create_by(feature_key: feature_key)
      end
    end

    if listing_hash["image_urls"]
      new_listing.related_urls["images"] = listing_hash["image_urls"]
      # Jan 2020 - for now will just save original image urls
      # max_photos_to_process = 2
      # # uploading images can slow things down so worth setting a limit
      # listing_hash["image_urls"].each_with_index do |image_url, index|
      #   if (index + 1) > max_photos_to_process
      #     break
      #   end
      #   if new_listing.is_a? SaleListing
      #     photo = SaleListingPhoto.create
      #   else
      #     photo = RentalListingPhoto.create
      #   end
      #   # photo.sort_order = image_url["sort_order"] || nil
      #   photo.sort_order = index + 1
      #   photo.remote_image_url = image_url
      #   photo.save!
      #   new_listing.listing_photos.push photo
      # end
    end
    new_listing.save!
    return new_listing
  end

  private
end
