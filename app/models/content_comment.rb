class ContentComment < ApplicationRecord
  belongs_to :content, foreign_key: "content_uuid", primary_key: "uuid", optional: true
  belongs_to :guest, foreign_key: "guest_uuid", primary_key: "uuid", optional: true
  belongs_to :access_token, foreign_key: "access_token_uuid", primary_key: "uuid", optional: true
  belongs_to :user, foreign_key: "user_uuid", primary_key: "uuid", optional: true

  def commenter_name
    access_token ? access_token.invitee_nickname : "Anon"
  end
end
