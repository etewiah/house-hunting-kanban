class ApiPublic::V1::ContentCommentsController < ApiPublicApplicationController
  # respond_to :json
  # caches_page :single, :list
  # before_action :set_content, only: [:show]

  # # GET /contents/new
  # def new
  #   @content_comment = Content.new
  # end

  # # GET /contents/1/edit
  # def edit
  # end

  def update
    @content = Content.find_by_uuid(params[:content_uuid])
    @content_comment = ContentComment.find_by_uuid(params[:comment_uuid])
    access_token = AccessToken.find_by_uuid(params[:access_token_uuid])

    am = AccessManager.new(content: @content, access_token: access_token)
    @current_access = am.get_access
    respond_to do |format|
      if @content_comment.access_token.uuid == params[:access_token_uuid]
        @content_comment.raw = params[:raw]
        @content_comment.save!
        access_token.invitee_nickname = params[:name]
        access_token.save!
        format.json { render "api_public/v1/contents/show.json", status: :created }
      else
        # format.html { render :new }
        format.json {
          render json: {
                   message: "Sorry, unable to save changes",
                 }, status: :unprocessable_entity
        }
      end
    end
  end

  def create
    @content = Content.find_by_uuid(params[:content_uuid])
    access_token = AccessToken.find_by_uuid(params[:access_token_uuid])
    unless access_token
      # TODO - return error here if anon_access_level for content is not
      # view_and_comment
      tm = TokensManager.new
      access_token = tm.create_access @content, @content.anon_access_level, @content.anon_edit_role
      #  "full_edit"
      access_token.reload
    end
    # access_token_uuid = access_token ? access_token.uuid : ""
    @content_comment = ContentComment.create(
      {
        raw: params[:new_comment],
        content_uuid: @content.uuid,
        access_token_uuid: access_token.uuid,
      }
    )
    if params[:new_name].present?
      access_token.invitee_nickname = params[:new_name].capitalize
      access_token.save!
    end

    unless access_token.invitee_nickname.present?
      access_token.invitee_nickname = Haikunator.haikunate(0, " ").titleize
      # Jan 2019 TODO - check generated name doesn't already exist
      access_token.save!
    end
    #

    am = AccessManager.new(content: @content, access_token: access_token)
    @current_access = am.get_access

    respond_to do |format|
      if @content_comment.save
        format.json { render "api_public/v1/contents/show.json", status: :created }
      else
        # format.html { render :new }
        format.json { render json: @content_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  # def set_content
  #   @content_comment = Content.find_by_uuid(params[:id])
  # end

  # # Never trust parameters from the scary internet, only allow the white list through.
  # def content_params
  #   params.require(:content).permit(:raw, :slug)
  #   # params.fetch(:content, {})
  #   # above is same as:
  #   # params[:content] || {}
  # end
end
