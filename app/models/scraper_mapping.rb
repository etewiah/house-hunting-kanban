require 'active_hash'
# https://github.com/zilkey/active_hash
class ScraperMapping < ActiveJSON::Base
  # set_filename "config"
  # not possible to set primary_key like so:
  # self.primary_key = :name

  set_root_path "#{Rails.root}/config/scraper_mappings"
  use_multiple_files
  # when adding new files, need to restart server and ensure correct name
  # is used in corresponding json file
  set_filenames "zoopla_for_sale", "idealista", "fotocasa"
   # 'inmo1', 'pwb1', 'rightmove',
   #  'h2m', 'h2m_page', 'zoopla_for_sale',
   #  'openvilla'
end
