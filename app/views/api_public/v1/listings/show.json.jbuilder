json.success true
json.listing do
  json.notes do
    json.array!(@listing_with_asset.notes) do |note|
      json.(note,
            "id",
            "uuid",
            "updated_at",
            "user_id",
            "title")
    end
  end
  json.(@listing_with_asset,
        # "listing_photos",
        "image_urls",
        "uuid",
        "title",
        "description", "price_sale_current_cents",
        "longitude", "latitude", "import_url",
        # "notes",
        "model_name")
end
