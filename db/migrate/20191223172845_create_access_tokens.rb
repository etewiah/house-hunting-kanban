class CreateAccessTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :access_tokens do |t|
      t.uuid :uuid, default: -> { "gen_random_uuid()" }
      t.uuid :guest_uuid
      t.uuid :user_uuid
      t.uuid :invited_by_guest_uuid
      t.uuid :invited_by_user_uuid
      t.uuid :content_uuid
      t.string :invitee_nickname
      t.boolean :is_creator_token, default: false
      t.integer :invitation_state, default: 0, null: false, index: true
      t.integer :flags, default: 0, null: false, index: true
      t.integer :access_level, default: 0, null: false, index: true
      t.integer :edit_role, default: 0, null: false, index: true
      # could_do : add is_creator, granted_by/granted_by_guest_uuid, invitee_nickname (can be used by multiple people??)
      # and association with invites
      t.datetime :last_accessed_at
      t.datetime :valid_from
      t.datetime :valid_till
      t.timestamps
    end
  end
end
