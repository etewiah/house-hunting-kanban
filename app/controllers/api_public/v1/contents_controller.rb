class ApiPublic::V1::ContentsController < ApiPublicApplicationController
  # respond_to :json
  # caches_page :single, :list
  # before_action :set_content, only: [:show]
  # , :edit, :update, :destroy]
  # before_action :refresh_csrf_token

  # GET /contents
  # GET /contents.json
  # def index
  #   @contents = Content.all
  #   # byebug
  #   render "index.json"
  # end

  # GET /contents/1
  # GET /contents/1.json
  def show
    # render "show.json"
    # Dec 2019 - endpoint for settings - only needed so I can return csrf token in header
    render json: {}
  end

  def check_guest_name
    content = Content.find_by_uuid(params[:uuid])
    new_name = params[:new_guest_name]
    name_exists = false

    # TODO - write specs for below:
    content.access_tokens.pluck("invitee_nickname").each do |nickname|
      if new_name.downcase.strip == nickname.to_s.downcase.strip
        name_exists = true
      end
    end
    render json: {
      name_exists: name_exists
    }
  end

  def show_by_uuid
    # @viewable = "none"
    # @manageable = "none"
    @upgrade_errors = []
    @content = Content.find_by_uuid(params[:uuid])

    access_token = AccessToken.find_by_uuid(params[:access_token])
    am = AccessManager.new(content: @content, access_token: access_token)
    @current_access = am.get_access
    #  @content, "full_access", "full_edit"

    if @current_access[:edit_role] == "full_edit"
      render "api_public/v1/elevated/contents/show.json"
    else
      render "show.json"
    end
  end

  # # GET /contents/new
  # def new
  #   @content = Content.new
  # end

  # # GET /contents/1/edit
  # def edit
  # end

  # POST /contents
  # POST /contents.json
  def create
    @content = Content.new(content_params)

    # Dec 2019 - for now defaulting to view_and_comment for new content
    @content.anon_access_level = "view_and_comment"
    respond_to do |format|
      if @content.save
        tm = TokensManager.new
        @creator_token = tm.create_access @content, "full_access", "full_edit"
        @creator_token.reload
        @content.reload
        # format.html { redirect_to @content, notice: "Content was successfully created." }
        # format.json { render :show_new, status: :created, location: @content }
        # location above is not relevant for my use case
        # https://en.wikipedia.org/wiki/HTTP_locationhttps://en.wikipedia.org/wiki/HTTP_location
        format.json { render :show_new, status: :created }
      else
        # format.html { render :new }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

  # # PATCH/PUT /contents/1
  # # PATCH/PUT /contents/1.json
  # def update
  #   respond_to do |format|
  #     if @content.update(content_params)
  #       # format.html { redirect_to @content, notice: "Content was successfully updated." }
  #       # format.json { render :show, status: :ok, location: @content }
  #       format.json { render :show, status: :ok, location: @content }

  #       # https://en.wikipedia.org/wiki/HTTP_locationhttps://en.wikipedia.org/wiki/HTTP_location
  #     else
  #       # format.html { render :edit }
  #       format.json { render json: @content.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /contents/1
  # # DELETE /contents/1.json
  # def destroy
  #   @content.destroy
  #   respond_to do |format|
  #     # format.html { redirect_to contents_url, notice: "Content was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  private

  # # Use callbacks to share common setup or constraints between actions.
  # def set_content
  #   @content = Content.find_by_uuid(params[:id])
  # end

  # Never trust parameters from the scary internet, only allow the white list through.
  def content_params
    params.require(:content).permit(:raw, :slug)
    # params.fetch(:content, {})
    # above is same as:
    # params[:content] || {}
  end
end
