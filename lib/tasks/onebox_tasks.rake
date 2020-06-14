# # frozen_string_literal: true

# namespace :cm do
#   desc "test_kimurai"
#   # bundle exec rails cm:test_kimurai[marbella]
#   # 5 jan 2020
#   task :test_kimurai, [:tenant_name] => :environment do |_t, args|
#     require "kimurai"
#     target_url = "https://www.idealista.com/inmueble/85739254/"
#     #  "https://www.zoopla.co.uk/for-sale/details/52846397"
#     #  "https://www.rightmove.co.uk/property-to-rent/property-64593024.html"
#     result = Spiders::ExampleSpider.parse!(:parse, url: target_url)
#     byebug
#   end

#   desc "test_onebox"
#   # bundle exec rails cm:test_onebox[marbella]
#   # 5 jan 2020
#   task :test_onebox, [:tenant_name] => :environment do |_t, args|
#     require "onebox"

#     url = "http://www.amazon.com/gp/product/B005T3GRNW/ref=s9_simh_gw_p147_d0_i2"
#     preview = Onebox.preview(url)
#     debugger
#     # tenant_name = parse_tenant_arg args
#     # if tenant_name
#     #   Apartment::Tenant.switch(tenant_name) do
#     #   end
#     # end
#   end

#   private
# end
