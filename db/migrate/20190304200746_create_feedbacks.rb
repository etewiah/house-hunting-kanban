class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacks do |t|
      # t.uuid :uuid, default: -> { "gen_random_uuid()" }
      t.integer  :flags, default: 0, null: false, index: true

      t.string :title
      t.string :name
      t.string :email
      t.boolean :can_be_contacted
      t.text :positive
      t.text :negative
      t.text :other
      t.string :origin_ip
      t.string :user_agent
      t.float :longitude
      t.float :latitude
      t.string :locale
      t.string :host
      t.string :url
      t.string :project_uuid

      t.integer :user_id
      t.json :details, default: {}

      # and discarded gem:
      t.datetime :discarded_at, index: true

      t.timestamps
    end
  end
end
