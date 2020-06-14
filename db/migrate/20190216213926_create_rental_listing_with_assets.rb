class CreateRentalListingWithAssets < ActiveRecord::Migration[5.2]
  def change
    create_view :rental_listing_with_assets
  end
end
