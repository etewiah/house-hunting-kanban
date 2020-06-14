require 'active_hash'
# aug 2018 - allows me to control which urls to attempt to parse
# replaces import_host model in pws
# used by imports_controller
# https://github.com/zilkey/active_hash
class SupportedScraperHosts < ActiveJSON::Base
  # set_filename "config"
  # not possible to set primary_key like so:
  # self.primary_key = :name

  set_root_path "#{Rails.root}/config/supported_scraper_hosts"
  use_multiple_files
  # when adding new files, need to restart server and ensure correct name
  # is used in corresponding json file
  # // names correspond to apt tenants
  set_filenames 'default'
  # 'glenwood','openvilla'
  # , 'h2m'
end
