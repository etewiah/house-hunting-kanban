ActiveAdmin.register Content do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :uuid, :authentication_token, :flags, :status, :views_count, :is_private, :is_secured, :is_published, :anon_access_level, :anon_edit_role, :raw, :cooked, :url, :slug, :description, :title, :sha1, :sha256, :other_hash, :other_hash_type, :visible_from, :visible_till, :to_destroy_at, :to_discard_at, :discarded_at
  #
  # or
  #
  # permit_params do
  #   permitted = [:uuid, :authentication_token, :flags, :status, :views_count, :is_private, :is_secured, :is_published, :anon_access_level, :anon_edit_role, :raw, :cooked, :url, :slug, :description, :title, :sha1, :sha256, :other_hash, :other_hash_type, :visible_from, :visible_till, :to_destroy_at, :to_discard_at, :discarded_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
