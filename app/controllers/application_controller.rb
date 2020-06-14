class ApplicationController < ActionController::Base
  respond_to :json, :html
  # above needed for devise to respond with json (as well as X-Requested-With header from client)
  before_action :set_pack_name_and_meta_tags

  def set_pack_name_and_meta_tags
    @pack_name = "pisocake"
    @page_title = "House hunting made easier"
    @page_description = "Get help from your friends when house hunting."
    @page_keywords = "Chat with maps, house hunting"
  end
end
