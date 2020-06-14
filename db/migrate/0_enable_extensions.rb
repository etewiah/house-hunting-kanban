class EnableExtensions < ActiveRecord::Migration[5.1]
  def change
    enable_extension "plpgsql"
    enable_extension 'uuid-ossp'
    enable_extension 'pgcrypto'
  end
end
# need to have this migration first so that use of gen_random_uuid will work:
# https://stackoverflow.com/questions/47064090/rails-postgres-migration-why-am-i-receiving-the-error-pgundefinedfunction