class Content < ApplicationRecord
  has_many :comments, foreign_key: "content_uuid", class_name: "ContentComment", primary_key: "uuid"
  has_many :access_tokens, foreign_key: "content_uuid", class_name: "AccessToken", primary_key: "uuid"
  has_many :access_invitations, foreign_key: "content_uuid", class_name: "AccessInvitation", primary_key: "uuid"

  enum anon_access_level: { no_access: 0, full_access: 2, view_only: 4, view_and_comment: 6 }
  enum anon_edit_role: { no_edit: 0, full_edit: 2 }
end
