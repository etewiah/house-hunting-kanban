class ApiPublicApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # respond_to :json

  before_action :refresh_csrf_token

  # before_action :set_locale, :set_meta
  after_action :track_action

  def refresh_csrf_token
    response.headers["X-CSRF-Token"] = form_authenticity_token.to_s
    response.headers["X-CSRF-Param"] = "authenticity_token"
  end

  private

  def track_action
    safely do
      # above provided by gem "safely_block"
      # return if current_visit.browser == "Wget"
      props = {
        is_public_api: true,
        i18n_locale: I18n.locale,
        verb: request.method,
        url: request.url,
        params: request.filtered_parameters,
      }
      ahoy.track "Called #{controller_name}##{action_name}", props

      unless current_visit.host.present?
        current_visit.host = request.host
        current_visit.save
      end
      event = current_visit.events.last
      if props[:params]["access_token"]
        event.access_token_uuid = props[:params]["access_token"]
        event.save
      end
    end
  end

  # def get_default_search_params(params, search_fields)
end
