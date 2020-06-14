Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    #   devise_for :users
    get "/p/:uuid" => "contents#empty"
    get "/p/:uuid/*ignore" => "contents#empty"
    #   get "/f/:uuid" => "contents#show"
    #   get "/f/:uuid/*ignore" => "contents#show"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api_public do
    namespace :v1 do
      scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
        get "/imports/project_from_webpage" => "imports#project_from_webpage"
        get "/imports/add_webpage" => "imports#add_webpage"
        resources :projects
        put "/listings/add_note/:listing_id" => "listings#add_note"
        get "/listings/:listing_id" => "listings#show"
        put "/feedback" => "feedback#add"
      end
    end
  end

  root "start#index"
end
