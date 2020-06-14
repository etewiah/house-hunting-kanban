# frozen_string_literal: true

json.success_message @success_message
json.content do
  json.set! :access_token_uuid, @creator_token.uuid
  json.set! :edit_role, @creator_token.edit_role
  json.set! :access_level, @creator_token.access_level
  # json.set! :upgrade_errors, @upgrade_errors
  json.(@content,
        "uuid",
        "slug",
        # "substance",
        "raw",
        "updated_at")
end
