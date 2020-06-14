class TokensManager
  attr_accessor :enable_geocode

  def initialize(**keyword_args)
    # https://www.justinweiss.com/articles/fun-with-keyword-arguments/
    # self.listing_hash = listing_hash
    self.enable_geocode = keyword_args["enable_geocode"] || keyword_args[:enable_geocode] || false
  end

  def create_access(content, access_level, edit_role)
    content.reload
    # above just in case content is newly created and doesn't have uuid
    # content = Content.last
    token = create_for_content content
    token.access_level = access_level
    token.edit_role = edit_role
    token.save
    token
  end

  def create_for_content(content)
    token = AccessToken.create(
      {
        content_uuid: content.uuid,
      }
    )
    # I18n.locale = current_locale
  end

  private
end
