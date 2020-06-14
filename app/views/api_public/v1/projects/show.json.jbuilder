json.success true
json.project do
  json.set! :title, @project.title || "Our new house hunting project"
  json.(@project,
        "id",
        "description")
  json.for_sale do
    json.array!(@project.sale_listing_with_assets) do |sale_listing_with_asset|
      json.notes do
        json.array!(sale_listing_with_asset.notes) do |note|
          json.(note,
                "id",
                "uuid",
                "updated_at",
                "user_id",
                "title")
        end
      end
      json.(sale_listing_with_asset,
            # "listing_photos",
            "image_urls",
            "uuid",
            "title",
            "description", "price_sale_current_cents",
            "longitude", "latitude", "import_url",
            # "notes",
            "model_name")
    end
  end
  json.for_rental do
    json.array!(@project.rental_listing_with_assets) do |rental_listing_with_asset|
      json.notes do
        json.array!(rental_listing_with_asset.notes) do |note|
          json.(note,
                "id",
                "uuid",
                "updated_at",
                "user_id",
                "title")
        end
      end
      json.(rental_listing_with_asset,
            # "listing_photos",
            "image_urls",
            "uuid",
            "title",
            "description", "price_rental_monthly_standard_season_cents",
            "longitude", "latitude", "import_url",
            # "notes",
            "model_name")
    end
  end
end
