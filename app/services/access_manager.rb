class AccessManager
  attr_accessor :access_token, :content

  def initialize(access_token:, content:)
    # def initialize(**keyword_args)
    # https://www.justinweiss.com/articles/fun-with-keyword-arguments/
    # self.listing_hash = listing_hash
    self.access_token = access_token
    self.content = content
    # self.access_token = keyword_args["access_token"] || keyword_args[:access_token] || false
  end

  def get_access()
    current_access = {
      access_level: content.anon_access_level,
      edit_role: content.anon_edit_role,
    # access_level: "no_access",
    # edit_role: "no_edit",
    }
    # unless content.is_private
    #   current_access[:access_level] = "view_only"
    # end
    # unless content.is_secured
    #   current_access[:access_level] = "view_and_comment"
    # end

    if access_token && (access_token.content == content)
      current_access[:access_level] = access_token.access_level
      current_access[:edit_role] = access_token.edit_role
      current_access[:uuid] = access_token.uuid
      current_access[:nickname] = access_token.invitee_nickname
    end
    # debugger
    return current_access
  end

  private
end
