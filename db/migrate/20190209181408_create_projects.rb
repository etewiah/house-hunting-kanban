class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    postgres = ActiveRecord::Base.connection.adapter_name == "PostgreSQL"
    # rails_42 = Gem::Version.new(ActiveRecord::VERSION::STRING) < Gem::Version.new("5.0.0")
    enable_extension "pgcrypto" if postgres

    # https://github.com/influitive/apartment/issues/342
    enable_extension 'uuid-ossp' if postgres # => http://theworkaround.com/2015/06/12/using-uuids-in-rails.html#postgresql
    # Jan 2019 - added above while trying to solve
    # PG::UndefinedFunction: ERROR:  function gen_random_uuid() does not exist

    if postgres
      create_table(:projects, id: :uuid, default: 'gen_random_uuid()', force: false) do |t|
        t.string      :slug
        t.binary      :metadata
        t.integer :flags, default: 0, index: true, null: false
        t.json :details, default: {}

        # below for mobility:
        t.jsonb :translations, default: {}
        # and discarded gem:
        t.datetime :discarded_at, index: true

        t.jsonb :categories, null: false, default: {}
        # below will save a cityname without accents etc
        t.string :city_search_key, default: "", null: false, index: true
        t.json :related_urls, default: {}

        # t.datetime    :created_at,  null: false
        t.timestamps
      end
    end


    # add_index :projects, :uuid, :unique => true
    # above needed?
    add_index :projects, :slug, :unique => true
    add_index  :projects, :categories, using: :gin

  end
end
