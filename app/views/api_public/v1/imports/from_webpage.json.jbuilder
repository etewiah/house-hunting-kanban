# Jan 2020 - to delete - no longer in use
# json.success true
# json.project do
#   json.(@project,
#         "id",
#         "title", "description")
#   json.for_sale do
#     json.array!(@project.sale_listing_with_assets) do |sale_listing_with_asset|
#       json.(sale_listing_with_asset,
#             "listing_photos",
#             "id", "title",
#             "description", "price_sale_current_cents",
#             "longitude", "latitude", "import_url",
#             "notes",
#             "model_name")
#     end
#   end
#   json.for_rental do
#     json.array!(@project.rental_listing_with_assets) do |rental_listing_with_asset|
#       json.(rental_listing_with_asset,
#             "listing_photos",
#             "id", "title",
#             "description", "price_rental_monthly_standard_season_cents",
#             "longitude", "latitude", "import_url",
#             "notes",
#             "model_name")
#     end
#   end
# end
