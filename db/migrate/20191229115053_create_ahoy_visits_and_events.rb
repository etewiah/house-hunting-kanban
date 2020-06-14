class CreateAhoyVisitsAndEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :ahoy_visits do |t|
      t.string :visit_token
      t.string :visitor_token

      # the rest are recommended but optional
      # simply remove any you don't want

      # user
      t.references :user

      # standard
      t.string :ip
      t.text :user_agent
      t.text :referrer
      t.string :referring_domain
      t.text :landing_page

      # technology
      t.string :browser
      t.string :os
      t.string :device_type

      # location
      t.string :country
      t.string :region
      t.string :city
      t.float :latitude
      t.float :longitude

      # utm parameters
      t.string :utm_source
      t.string :utm_medium
      t.string :utm_term
      t.string :utm_content
      t.string :utm_campaign

      # native apps
      t.string :app_version
      t.string :os_version
      t.string :platform

      t.timestamp :started_at

      # Dec 2019: Extras added for chattyboards:
      # In the long run want to replace user_id with user_uuid
      t.uuid :user_uuid
      t.uuid :guest_uuid

      t.string :host
      # t.uuid :content_uuid
      # t.uuid :access_token_uuid
      # above 2 should be has_many assocs created by AddVisitIdToModels
      t.integer :flags, default: 0, null: false # normally I'd index flags but not this time: , index: true
    end

    add_index :ahoy_visits, [:visit_token], unique: true

    create_table :ahoy_events do |t|
      t.references :visit
      t.references :user

      t.string :name
      t.jsonb :properties
      t.timestamp :time

      # Dec 2019: Extras added for chattyboards:
      # In the long run want to replace user_id with user_uuid
      t.uuid :user_uuid
      t.uuid :guest_uuid
      t.uuid :content_uuid
      t.uuid :access_token_uuid
    end

    add_index :ahoy_events, [:name, :time]
    add_index :ahoy_events, :properties, using: :gin, opclass: :jsonb_path_ops
  end
end
