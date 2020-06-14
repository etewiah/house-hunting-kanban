# frozen_string_literal: true

json.success true # @success
json.timelystamp do
  # json.set! :access, @current_access
  json.is_new @is_new
  if @latest_verification.present?
    json.latest_verification do
      # json.set! :access, @current_access
      json.(@latest_verification,
            "body_sha256",
            "timestamped_at")
    end
  end
  json.(@timelystamp,
        # "uuid",
        # "anon_access_level",
        # "anon_edit_role",
        # "is_secured",
        # "is_private",
        "url",
        "slug",
        "body_sha256",
        "url_sha256",
        # "created_at",
        "timestamped_at")
  # json.comments do
  #   json.array!(@timelystamp.comments) do |comment|
  #     json.(comment,
  #           "commenter_name",
  #           # "created_at",
  #           "updated_at",
  #           "raw",
  #           "uuid")
  #     if @current_access[:uuid] == comment.access_token_uuid
  #       json.set! :access_token_uuid, comment.access_token_uuid
  #     end
  #   end
  # end
end
