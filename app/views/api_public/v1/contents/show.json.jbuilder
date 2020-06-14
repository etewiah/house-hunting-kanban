# frozen_string_literal: true

json.success_message @success_message
json.content do
  json.set! :access, @current_access
  json.(@content,
        "uuid",
        "anon_access_level",
        "anon_edit_role",
        # "is_secured",
        # "is_private",
        "slug",
        # "substance",
        "raw",
        "created_at",
        "updated_at")
  json.comments do
    json.array!(@content.comments) do |comment|
      json.(comment,
            "commenter_name",
            # "created_at",
            "updated_at",
            "raw",
            "uuid")
      if @current_access[:uuid] == comment.access_token_uuid
        json.set! :access_token_uuid, comment.access_token_uuid
      end
    end
  end
end
