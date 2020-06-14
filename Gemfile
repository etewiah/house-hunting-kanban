source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.2'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'ahoy_matey'
gem 'safely_block'
gem 'redis'
# above needed for below
gem 'logster'
gem 'meta-tags'
gem 'devise'
gem 'activeadmin'
gem 'druuid'
gem 'haikunator'
gem 'active_hash'
gem 'money-rails'
gem 'scenic'
# below allows 'soft deletes'
gem 'discard'
gem 'mobility'
gem 'carrierwave'
# gem 'mini_magick'
# gem 'onebox'
# Jan 2020 - commented out above as it has
# nokogumbo as dependency and that could not be installed 
# when I pushed to dokku
# After above also had to comment out below as it also
# let to an error (to do with memory on the server??)
# Make sure that `gem install unf_ext -v '0.0.7.6' succeeds first
# gem 'kimurai'
# Jan 2020: considered using below to create "canonical urls" but doesn't seem any better than standard URI
# gem 'addressable'

# gem 'rails_event_store'
# gem 'devise'
# gem 'apartment'
# gem 'geocoder'

# gem 'paper_trail'

# gem 'flag_shih_tzu'

# gem 'i18n-active_record'
# # below used in an apartment task as a simplified way of doing backups:
# gem 'seed_dump'

# gem 'rails_event_store'
# gem 'paper_trail'

# # # below for caching in production:
# gem 'redis-rails'

# gem 'mailjet'
# gem 'rack-cors'


# gem 'fog-aws'
# gem 'asset_sync'
# # may 2019 TODO add and use the ff:
# # gem 'rails_email_preview', '~> 2.2.1'

# # https://github.com/ytbryan/vue_on_rails_ssr
# gem 'hypernova'

# gem 'blazer'
# gem 'google-maps'

# gem 'money-rails'
