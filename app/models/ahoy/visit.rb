class Ahoy::Visit < ApplicationRecord
  self.table_name = "ahoy_visits"

  # has_many :contacts, class_name: "Contact"
  # has_many :messages
  # class AddVisitIdToModels < ActiveRecord::Migration[5.2]
  #   def change
  #     add_column :messages, :visit_id, :bigint
  #     add_column :contacts, :visit_id, :bigint
  #   end
  # end

  has_many :events, class_name: "Ahoy::Event"
  belongs_to :user, optional: true
end
