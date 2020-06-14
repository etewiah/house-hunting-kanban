class CreateAccessInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :access_invitations do |t|
      t.uuid :uuid, default: -> { "gen_random_uuid()" }
      t.uuid :guest_uuid
      t.uuid :user_uuid
      t.uuid :invited_by_guest_uuid
      t.uuid :invited_by_user_uuid
      t.uuid :content_uuid
      t.string :invitee_nickname
      t.integer :invitation_state, default: 0, null: false, index: true
      t.integer :flags, default: 0, null: false, index: true
      t.integer :access_level, default: 0, null: false, index: true
      t.integer :edit_role, default: 0, null: false, index: true

      # t.datetime :last_accessed_at
      t.datetime :invited_at
      t.datetime :invitation_accepted_at
      t.timestamps
    end
  end
end
