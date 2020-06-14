ActiveAdmin.register AccessToken do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :uuid, :guest_uuid, :user_uuid, :invited_by_guest_uuid, :invited_by_user_uuid, :content_uuid, :invitee_nickname, :is_creator_token, :invitation_state, :flags, :access_level, :edit_role, :last_accessed_at, :valid_from, :valid_till
  #
  # or
  #
  # permit_params do
  #   permitted = [:uuid, :guest_uuid, :user_uuid, :invited_by_guest_uuid, :invited_by_user_uuid, :content_uuid, :invitee_nickname, :is_creator_token, :invitation_state, :flags, :access_level, :edit_role, :last_accessed_at, :valid_from, :valid_till]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
