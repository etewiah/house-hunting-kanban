-- rails generate scenic:model sale_listing_with_asset
SELECT 
  sale_listings.project_uuid,
  sale_listings.discarded_at,
  sale_listings.id,
  sale_listings.reference,
  sale_listings.flags,
  sale_listings.furnished,
  sale_listings.reserved,
  sale_listings.highlighted,
  sale_listings.archived,
  sale_listings.visible,
  sale_listings.hide_map,
  sale_listings.obscure_map,
  sale_listings.main_video_url,
  sale_listings.details,
  sale_listings.related_urls,
  sale_listings.publish_from,
  sale_listings.publish_till,
  sale_listings.realty_asset_id,
  sale_listings.translations,
  sale_listings.price_sale_current_cents,
  sale_listings.price_sale_current_currency,
  sale_listings.price_sale_original_cents,
  sale_listings.price_sale_original_currency,
  sale_listings.commission_cents,
  sale_listings.commission_currency,
  sale_listings.service_charge_yearly_cents,
  sale_listings.service_charge_yearly_currency,
  -- sale_listings.price_rental_monthly_for_search_cents,
  -- sale_listings.price_rental_monthly_for_search_currency,
  -- sale_listings.price_rental_daily_for_search_cents,
  -- sale_listings.price_rental_daily_for_search_currency,
  sale_listings.currency,
  sale_listings.import_url,
  sale_listings.created_at,
  sale_listings.updated_at,
  realty_assets.reference AS asset_reference,
  realty_assets.longitude,
  realty_assets.latitude,
  realty_assets.year_construction,
  realty_assets.count_bathrooms,
  realty_assets.count_bedrooms,
  realty_assets.count_toilets,
  realty_assets.count_garages,
  realty_assets.plot_area,
  realty_assets.constructed_area,
  realty_assets.area_unit,
  realty_assets.energy_rating,
  realty_assets.energy_performance,
  realty_assets.street_number,
  realty_assets.street_name,
  realty_assets.street_address,
  realty_assets.postal_code,
  realty_assets.province,
  realty_assets.city,
  realty_assets.city_search_key,
  realty_assets.region,
  realty_assets.country,
  realty_assets.floor,
  realty_assets.neighborhood,
  realty_assets.neighborhood_search_key,
  realty_assets.google_place_id
  -- pages.translations AS shared_page_translations
 FROM sale_listings,
  realty_assets
-- LEFT JOIN pages 
--   ON pages.slug = 'sale_listing_shared_page'
WHERE (sale_listings.realty_asset_id = realty_assets.id);
-- results = ActiveRecord::Base.connection.exec_query("select * from sale_listings, realty_assets where realty_asset_id = realty_assets.id")