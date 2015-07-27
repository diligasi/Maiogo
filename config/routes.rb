Rails.application.routes.draw do

  resources :testimonials

  resources :static_page, only: 'static_page#autocomplete' do
    collection do
      get 'autocomplete'
    end
  end

  # match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/:provider/callback', to: 'static_page#testimonial_user', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

  match 'find_guest', to: 'static_page#find_guest', via: :post
  match 'confirm_guest', to: 'static_page#confirm_guest', via: :post
  match 'create_testimonial', to: 'static_page#create_testimonial', via: :post

  get '/new_testimonial', to: 'static_page#new_testimonial', as: 'new_testimonial_lightobx'

  root 'static_page#index'
end
