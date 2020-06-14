class SaleListingPhoto < PhotoRecord
  belongs_to :sale_listing, optional: true

end
