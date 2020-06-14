class CreateSaleListingWithAssets < ActiveRecord::Migration[5.2]
  def change
    create_view :sale_listing_with_assets
  end
end
