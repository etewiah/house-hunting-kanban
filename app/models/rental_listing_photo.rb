class RentalListingPhoto < PhotoRecord
  belongs_to :rental_listing, optional: true

end
