# Acts as association between content and guests / users
class AccessToken < ApplicationRecord
  has_many :comments, foreign_key: "access_token_uuid", class_name: "ContentComment", primary_key: "uuid"
  # belongs_to :user, foreign_key: "user_uuid", primary_key: "uuid", optional: true
  belongs_to :guest, foreign_key: "guest_uuid", primary_key: "uuid", optional: true
  belongs_to :content, foreign_key: "content_uuid", primary_key: "uuid", optional: true
  # has_many :listing_photos, -> { order "sort_order asc" }, class_name: "SaleListingPhoto", foreign_key: "sale_listing_id"

  # enum title: [ :no_access, :view_only ]
  # above method of declaring less flexible than below:
  enum access_level: { no_access: 0, full_access: 2, view_only: 4, view_and_comment: 6 }
  enum edit_role: { no_edit: 0, full_edit: 2 }
  # , can_delete: 4, can_moderate: 6 }
end
