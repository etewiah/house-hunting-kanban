class Guest < ApplicationRecord
  has_many :access_tokens, foreign_key: "guest_uuid", class_name: "AccessToken", primary_key: "uuid"
end
