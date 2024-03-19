Rails.application.routes.draw do
  resources :wedding_descriptions

  resources :galleries
  resources :invitation_texts
  resources :languages
  resources :gifts
  resources :pages
  resources :weddings
  devise_for :users, :controllers => { :invitations => 'users/invitations', :registrations => 'users/registrations', :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users
  resources :qandas

  get '/accept_wedding_invite/:id' => 'weddings#accept_wedding_invite', :as => 'accept_wedding_invite'
  get '/deny_wedding_invite/:id' => 'weddings#deny_wedding_invite', :as => 'deny_wedding_invite'
  get '/wedding_gifts/:wedding_id' => 'gifts#wedding_gifts', :as => 'wedding_gifts'
  get '/give' => 'gifts#give', :as => 'give'
  get '/go/:short_token' => 'visitors#accept_user_invitation', :as => 'go'
  get '/print_invitations' => 'weddings#print_invitations', :as => 'print_invitations'
  get '/as_guest/:wedding_id/:language_id' => 'weddings#as_guest', :as => 'as_guest'
  get '/wedding_qanda/:wedding_id' => 'qandas#wedding_qanda', :as => 'wedding_qanda'
  get '/wedding_galleries/:wedding_id' => 'galleries#wedding_galleries', :as => 'wedding_galleries'
  get '/playlist/:wedding_id' => 'weddings#playlist', :as => 'playlist'
  get '/add_song/:wedding_id/:song_id' => 'weddings#add_song', :as => 'add_song'

  authenticated :user do
    devise_scope :user do
      root to: "weddings#index"
    end
  end

  unauthenticated do
    devise_scope :user do
      root to: "start#index", :as => "unauthenticated"
    end
  end
end
