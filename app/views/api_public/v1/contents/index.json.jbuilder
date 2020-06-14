# frozen_string_literal: true

json.contents do
  json.array!(@contents) do |content|
    json.call(content,
              "uuid",
              "slug",
              # "substance",
              "raw",
              "updated_at")
    # json.set! :visit_url, "#{request.base_url}/api_admin/v3/visits/#{content.visit_id}"
  end
end
