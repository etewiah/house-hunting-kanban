class ApiPublic::V1::ListingsController < ApiPublicApplicationController
  def add_note
    @error_message = nil
    listing = SaleListing.find_by_uuid params[:listing_id]
    new_note = Note.create({ sale_listing_id: listing.id })
    new_note.title = params[:note]
    new_note.save!

    if @error_message
      return render json: {
                      success: false,
                      error_message: @error_message,
                    }
    else
      @listing_with_asset = SaleListingWithAsset.find(listing.id)
      return render "show.json"
    end
  end

  def show
    listing = SaleListing.find_by_uuid params[:listing_id]
    @listing_with_asset = SaleListingWithAsset.find(listing.id)
    return render "show.json"
  end

  protected
end
