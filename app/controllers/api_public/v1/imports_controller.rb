class ApiPublic::V1::ImportsController < ApiPublicApplicationController
  def project_from_webpage
    @error_message = nil
    import_uri = check_url params

    unless @error_message.present?
      @listing = listing_from_url import_uri
      # , error_message
    end

    if @error_message
      return render json: {
                      success: false,
                      error_message: @error_message,
                    }
    else
      @project = Project.create!
      if @listing.is_a? SaleListing
        @project.sale_listings << @listing
      end
      if @listing.is_a? RentalListing
        @project.rental_listings << @listing
      end
      # @listing_with_asset = SaleListingWithAsset.find(@listing.id)
      return render "api_public/v1/projects/show.json"
    end
  end

  def add_webpage
    @error_message = nil
    import_uri = check_url params
    @project = check_for_project params

    unless @error_message.present?
      @listing = listing_from_url import_uri
    end
    if @error_message
      return render json: {
                      success: false,
                      error_message: @error_message,
                    }
    else
      # Add listing to project
      if @listing.is_a? SaleListing
        @project.sale_listings << @listing
      end
      if @listing.is_a? RentalListing
        @project.rental_listings << @listing
      end
      # @listing_with_asset = SaleListingWithAsset.find(@listing.id)
      return render "api_public/v1/projects/show.json"
    end
  end

  protected

  def check_for_project(params)
    unless params["project_uuid"]
      @error_message = "Please provide a project uuid"
      return
    end
    @project = Project.find params[:project_uuid]
    unless @project.present?
      @error_message = "Please provide a valid project uuid"
    end
    @project
  end

  def check_url(params)
    # error_message = nil
    unless params["url"]
      @error_message = "Please provide a url"
    end

    import_url = params["url"].to_s.chomp("/")
    # chomp("/") above will remove trailing slash if it exists
    uri = uri_from_url import_url.strip
    # below removes any querystrings
    uri.query = nil
    # MayDo - save query somewhere
    unless uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
      @error_message = "Please provide a valid url"
    end
    uri
  end

  def listing_from_url(uri)
    import_url = uri.to_s.chomp("/")
    @listing_model = SaleListing.find_by_import_url(import_url) || RentalListing.find_by_import_url(import_url)

    unless @listing_model.present?
      scraper_mapping = get_scraper_mapping uri.host

      if scraper_mapping[:error_message]
        @error_message = scraper_mapping[:error_message]
      else
        listing_hash = retrieve_hash_for_uri import_url, scraper_mapping
        listing_hash["import_url"] = import_url

        puts "#{listing_hash["import_url"]} retrieved"

        creator_params = {
          max_photos_to_process: 3,
          locales: ["en"],
        }

        @listing_model = save_hash_as_listing listing_hash, creator_params
      end
    end
    @listing_model
  end

  def get_scraper_mapping(uri_host)
    scraper_hosts = SupportedScraperHosts.find_by_name "default"
    if scraper_hosts.scraper_names_for_props.keys.include? uri_host
      scraper_name = scraper_hosts.scraper_names_for_props[uri_host]
      scraper_mapping = ::ScraperMapping.find_by_name(scraper_name)
      unless scraper_mapping
        # error here means I'm supposed to support this but there
        # has been an issue finding the mapping
        error_message = "Sorry, unable to process this url"
      end
    else
      error_message = "Please use a url from"
      scraper_hosts.scraper_names_for_props.keys.each_with_index do |scraper_name, index|
        if index == 0
          error_message += " #{scraper_name}"
        else
          error_message += " or #{scraper_name}"
        end
      end
      #{scraper_hosts.scraper_names_for_props.keys}"
    end

    if error_message
      return {
               error_message: error_message,
             }
    else
      return scraper_mapping
    end
  end

  def save_hashes_as_listings(property_hashes, creator_params)
    listings = []
    property_hashes.each do |property_hash|
      listing = save_hash_as_listing property_hash, creator_params
      listings.push listing
    end
    return listings
  end

  def save_hash_as_listing(property_hash, creator_params)
    listing_creator = ListingCreator.new(creator_params)
    listing = listing_creator.create_from_hash property_hash
    # prop = PropFromPwsListing pws_listing.as_json
    # TODO - have some logic for when to make visible
    listing.visible = true
    listing.save!
    puts "Prop with id #{listing.id} created"
    return listing
  end

  # def retrieve_hashes_for_xml_uri import_url, scraper_mapping
  #   if scraper_mapping
  #     xml_importer = XmlImporter.new(scraper_mapping)
  #   else
  #     # miTODO: - allow params to PropertyWebScraper::Scraper to decide expiry age etc.
  #     # until I refactor PWS, won't even allow bewlo
  #     # xml_importer = PropertyWebScraper::Scraper.new(import_host_model.scraper_name)
  #   end
  #   retrieved_properties = xml_importer.get_listings_from_url uri.to_s
  #   return retrieved_properties
  # end

  def retrieve_hash_for_uri(import_url, scraper_mapping)
    if scraper_mapping
      web_scraper = ::RealtyScrapers::WithNokogiri.new(nil, scraper_mapping)
      # PropertyWebScraper::Scraper also allows passing in a ScraperMapping as the
      # second param (for cases where PWS does not have it set up)..
    else
      # miTODO: - allow params to PropertyWebScraper::Scraper to decide expiry age etc.
      # until I refactor PWS, won't even allow bewlo
      # web_scraper = PropertyWebScraper::Scraper.new(import_host_model.scraper_name)
    end

    retrieved_properties = web_scraper.get_listing_from_url import_url
    return retrieved_properties[0]
  end

  def uri_from_url(import_url)
    begin
      uri = URI.parse import_url
    rescue URI::InvalidURIError => error
      uri = ""
    end
  end
end
