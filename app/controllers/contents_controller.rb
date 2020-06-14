class ContentsController < ApplicationController
  # before_action :set_content, only: [:show, :edit, :update, :destroy]

  def show
    @content = Content.find_by_uuid(params[:uuid])
    @page_title = @content.raw
    @page_description = "Super quick and easy forums."
    @page_keywords = "Throwaway forums, Instant chat"
  end

  def empty
    # @content = Content.new
    render "show"
  end

  private

  # # Use callbacks to share common setup or constraints between actions.
  # def set_content
  #   @content = Content.find(params[:id])
  # end

  # Never trust parameters from the scary internet, only allow the white list through.
  def content_params
    params.fetch(:content, {})
  end
end
