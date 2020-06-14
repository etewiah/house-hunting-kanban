# frozen_string_literal: true

# https://avdi.codes/service-objects/
# As per above, will avoid ceremony of creating an object
module ListingHashFromDoc
  def self.parse(doc, scraper_mapping, uri)
    # doc = Nokogiri::HTML(page_to_parse)
    listings = []
    # nov 2017 - only 1 property is ever returned currently

    property_hash = {
      "import_url" => uri.to_s,
    }

    if scraper_mapping.defaultValues
      scraper_mapping.defaultValues.keys.each do |mapping_key|
        mapping = scraper_mapping.defaultValues[mapping_key]
        property_hash[mapping_key] = mapping["value"]
      end
    end

    if scraper_mapping.images
      images_array = []
      scraper_mapping.images.each do |image_mapping|
        retrieved_array = retrieve_images_array doc, image_mapping, uri
        images_array += retrieved_array
      end
      # DONE: make this function useful for where there are multiple selectors / mappings
      # for images.
      # ChangedInOverride - implemented above using below
      property_hash["image_urls"] = images_array
    end
    # if scraper_mapping.features
    if scraper_mapping.as_json["attributes"].keys.include? "features"
      features_array = []
      scraper_mapping.features.each do |feature_mapping|
        retrieved_array = retrieve_features_array doc, feature_mapping, uri
        features_array += retrieved_array
      end
      # DONE: make this function useful for where there are multiple selectors / mappings
      # for features.
      # ChangedInOverride - implemented above using below
      property_hash["features"] = features_array
    end

    # if scraper_mapping.htmlFields
    # above would fails with:
    # NoMethodError: undefined method `htmlFields'
    # where htmlFields not defined
    if (scraper_mapping.respond_to? :htmlFields) && scraper_mapping.htmlFields
      scraper_mapping.htmlFields.keys.each do |mapping_key|
        mapping = scraper_mapping.htmlFields[mapping_key]
        retrieved_html = retrieve_target_html doc, mapping, uri
        property_hash[mapping_key] = retrieved_html
      end
    end

    if scraper_mapping.intFields
      scraper_mapping.intFields.keys.each do |mapping_key|
        mapping = scraper_mapping.intFields[mapping_key]
        retrieved_text = retrieve_target_content doc, mapping, uri
        property_hash[mapping_key] = retrieved_text.strip.to_i
      end
    end

    if scraper_mapping.floatFields
      scraper_mapping.floatFields.keys.each do |mapping_key|
        mapping = scraper_mapping.floatFields[mapping_key]
        retrieved_text = retrieve_target_content doc, mapping, uri
        # if mapping['comaToDot']
        #   retrieved_text = retrieved_text.strip.tr(',', '.')
        # end
        if mapping["stripNonNumbers"]
          retrieved_text = retrieved_text.gsub(/[^\d]/, "")
        end
        if mapping["stripPunct"]
          retrieved_text = retrieved_text.tr(".", "").tr(",", "")
        end
        if mapping["stripFirstChar"]
          retrieved_text = retrieved_text.strip.last(-1) || ""
        end
        if mapping["charsToClean"]
          retrieved_text = retrieved_text.tr(mapping["charsToClean"], "")
        end
        if mapping["multiplier"]
          property_hash[mapping_key] = retrieved_text.strip.to_f * mapping["multiplier"].to_f
        else
          property_hash[mapping_key] = retrieved_text.strip.to_f
        end
      end
    end

    if scraper_mapping.textFields
      scraper_mapping.textFields.keys.each do |mapping_key|
        mapping = scraper_mapping.textFields[mapping_key]
        retrieved_text = retrieve_target_content doc, mapping, uri
        # unless retrieved_text.present?
        # end
        retrieved_text = retrieved_text.nil? ? "" : retrieved_text
        property_hash[mapping_key] = retrieved_text.strip
      end
    end

    if scraper_mapping.booleanFields
      scraper_mapping.booleanFields.keys.each do |mapping_key|
        mapping = scraper_mapping.booleanFields[mapping_key]
        retrieved_text = retrieve_target_content doc, mapping, uri
        evaluator_text = mapping["evaluatorParam"]

        if mapping["caseInsensitive"]
          retrieved_text = retrieved_text.downcase
          evaluator_text = evaluator_text.downcase
        end
        # target_element = doc.css(mapping["cssLocator"])[mapping["cssCountId"].to_i] || ""
        property_hash[mapping_key] = retrieved_text.strip.send(mapping["evaluator"], evaluator_text)
      end
    end

    if scraper_mapping.booleanCalcs
      # feb 2019 -
      scraper_mapping.booleanCalcs.keys.each do |mapping_key|
        mapping = scraper_mapping.booleanCalcs[mapping_key]
        # below might be the value of the price_float field
        # in the current property_hash
        base_val = property_hash[mapping["field"]]
        # Means this code needs to run after that field has been retrieved

        comp_val = mapping["evalValue"].to_f

        if mapping["evaluator"] == "less_than"
          property_hash[mapping_key] = base_val < comp_val
        end

        if mapping["evaluator"] == "more_than"
          property_hash[mapping_key] = base_val > comp_val
        end
      end
    end
    listings.push property_hash
    listings
  end

  private

  def self.retrieve_features_array(doc, mapping, uri)
    retrieved_array = []
    if mapping["cssLocator"].present?
      css_elements = doc.css(mapping["cssLocator"])
      css_elements.each do |element|
        feature_text = get_text_from_css element, mapping
        retrieved_array.push feature_text
      end
    end

    # TODO - support xpath for features
    # if mapping['xpath'].present?
    #   css_elements = doc.css(mapping['xpath'])
    #   css_elements.each do |element|
    #     retrieved_array.push element.text
    #   end
    # end

    trimmed_and_stripped_array = []
    retrieved_array.each do |string_to_clean|
      cleaned_string = clean_up_string string_to_clean, mapping
      trimmed_and_stripped_array.push cleaned_string
      # string_to_clean.sub("_max_135x100", "")
    end
    trimmed_and_stripped_array
  end

  def self.retrieve_images_array(doc, mapping, uri)
    retrieved_array = []
    if mapping["cssLocator"].present?
      css_elements = doc.css(mapping["cssLocator"])
      css_elements.each do |element|
        # TODO - allow passing in of element to be evaluated
        # if mapping['cssAttr'] && element.attr(mapping['cssAttr'])
        #   img_url = element.attr(mapping['cssAttr'])
        # else
        #   img_url = element.text
        # end
        img_url = get_text_from_css element, mapping

        # ensure_url_is_absolute
        # TODO - move below into custom method
        img_uri = URI.parse(img_url)
        unless img_uri.host
          img_uri.scheme = uri.scheme
          img_uri.host = uri.host
          unless img_uri.path.start_with? "/"
            img_uri.path = "/" + img_uri.path
          end
          if mapping["imagePathPrefix"].present?
            # workaround for carusoimmobiliare with sucky url paths
            img_uri.path = mapping["imagePathPrefix"] + img_uri.path
          end
          img_url = img_uri.to_s
        end
        retrieved_array.push img_url
      end
    end

    if mapping["xpath"].present?
      css_elements = doc.css(mapping["xpath"])
      css_elements.each do |element|
        retrieved_array.push element.text
      end
    end
    trimmed_and_stripped_array = []
    retrieved_array.each do |string_to_clean|
      cleaned_string = clean_up_string string_to_clean, mapping
      trimmed_and_stripped_array.push cleaned_string
      # string_to_clean.sub("_max_135x100", "")
    end
    trimmed_and_stripped_array
  end

  def self.retrieve_target_html(doc, mapping, uri)
    retrieved_html = ""
    if mapping["nodesToRemove"].present?
      # introduced so I could remove instances of embedded
      # maps in h2m
      doc.css(mapping["nodesToRemove"]).remove
      # doc.search('//document/data').each do |node|
      #   node.remove
      # end
    end
    if mapping["cssLocator"].present?
      css_selected_content = doc.css(mapping["cssLocator"])
      # june 2018 - perhaps should make below configurable
      # but for now will just remove all scripts when retrieving html
      css_selected_content.search("script").remove
      retrieved_html = css_selected_content.to_html
      if mapping["asSanitizedHtml"] && retrieved_html.present?
        # if mapping['removeAllClasses']
        #   css_selected_content.xpath('//@class').remove
        # end

        html_cleaner = HtmlCleaner.new(retrieved_html)
        retrieved_html = html_cleaner.clean_html
      end
    end
    # if mapping['xpath'].present?
    #   css_elements = doc.xpath(mapping['xpath'])
    #   # able to retrieve xpath just like with css
    #   # but in future this might change
    #   retrieved_html = get_text_from_css css_elements, mapping
    # end

    # retrieved_html = clean_up_string retrieved_html, mapping
    return retrieved_html
  end

  def self.retrieve_target_content(doc, mapping, uri)
    retrieved_content = ""
    if mapping["scriptRegEx"].present?
      regex = Regexp.new mapping["scriptRegEx"]
      # "longitude:[^\,]*"
      # regex_results_array = doc.search("script").text.scan(regex) || [""]
      retrieved_content = doc.search("script").text.scan(regex)[0] || ""
      # aug 2018 below allows me to search within js objects that have extra info
      if mapping["regExInRegEx"].present?
        regex2 = Regexp.new mapping["regExInRegEx"]
        retrieved_content = retrieved_content.scan(regex2)[0] || ""
      end
      # retrieved_content = retrieved_content.split("\"")[1] || ""
    end
    if mapping["urlPathPart"].present?
      url_path_part = mapping["urlPathPart"]
      retrieved_content = get_text_from_url url_path_part, uri
    end
    if mapping["cssLocator"].present?
      css_selected_content = doc.css(mapping["cssLocator"])
      retrieved_content = get_text_from_css css_selected_content, mapping
    end
    if mapping["xpath"].present?
      css_elements = doc.xpath(mapping["xpath"])
      # able to retrieve xpath just like with css
      # but in future this might change
      retrieved_content = get_text_from_css css_elements, mapping
    end

    retrieved_content = clean_up_string retrieved_content, mapping
  end

  def self.clean_up_string(string_to_clean, mapping)
    unless mapping["splitTextCharacter"].nil?
      # - cannot use .present? above as splitTextCharacter is sometimes " "
      # mapping["splitTextCharacter"].present?
      #
      # in this case the element's text need to be split by the splitTextCharacter
      # splitTextArrayId refers to where in the resulting array
      # the correct item is
      begin
        splitTextCharacter = mapping["splitTextCharacter"] || " "
        splitTextArrayId = mapping["splitTextArrayId"].to_i
        string_to_clean = string_to_clean.split(splitTextCharacter)[splitTextArrayId]
        # in case above returns nil
        string_to_clean = string_to_clean || ""
      rescue Exception => e
      end
    end
    if mapping["stripString"].present?
      string_to_clean = string_to_clean.sub(mapping["stripString"], "")
    end
    string_to_clean
  end

  def self.get_text_from_url(url_path_part, uri)
    url_retrieved_text = uri.path
    if url_path_part.to_i > 0
      url_retrieved_text = uri.path.split("/")[url_path_part.to_i]
    end
    url_retrieved_text
  end

  def self.get_text_from_css(css_elements, mapping)
    # puts "#{css_elements} + #{mapping}"
    unless (css_elements.present?)
      return ""
    end
    css_retrieved_text = css_elements.text
    if mapping["cssAttr"] && css_elements.attr(mapping["cssAttr"])
      css_retrieved_text = css_elements.attr(mapping["cssAttr"]).text
    elsif mapping["xmlAttr"] && css_elements.attr(mapping["xmlAttr"])
      # xmlAttr for cases like idealister where element returned
      # is xml
      css_retrieved_text = css_elements.attr(mapping["xmlAttr"])
      # css_retrieved_text = css_elements.text
    end

    if mapping["cssCountId"].present?
      # in this case we have multiple elements matched
      # and the cssCountId refers to where in the list of matched elements
      # the correct item is
      begin
        css_count_id = mapping["cssCountId"].to_i
        css_retrieved_text = css_elements[css_count_id].text || ""
      rescue Exception => e
      end
    end
    css_retrieved_text
  end
end
