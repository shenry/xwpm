# == Route Map
#
#                Prefix Verb   URI Pattern                       Controller#Action
#                  root GET    /                                 pages#home
#                  home GET    /home(.:format)                   pages#home
#                inside GET    /inside(.:format)                 pages#inside
#      new_user_session GET    /users/sign_in(.:format)          devise/sessions#new
#          user_session POST   /users/sign_in(.:format)          devise/sessions#create
#  destroy_user_session DELETE /users/sign_out(.:format)         devise/sessions#destroy
#         user_password POST   /users/password(.:format)         devise/passwords#create
#     new_user_password GET    /users/password/new(.:format)     devise/passwords#new
#    edit_user_password GET    /users/password/edit(.:format)    devise/passwords#edit
#                       PATCH  /users/password(.:format)         devise/passwords#update
#                       PUT    /users/password(.:format)         devise/passwords#update
#     user_confirmation POST   /users/confirmation(.:format)     devise/confirmations#create
# new_user_confirmation GET    /users/confirmation/new(.:format) devise/confirmations#new
#                       GET    /users/confirmation(.:format)     devise/confirmations#show
#            admin_root GET    /admin(.:format)                  admin/base#index
#           admin_users GET    /admin/users(.:format)            admin/users#index
#                       POST   /admin/users(.:format)            admin/users#create
#        new_admin_user GET    /admin/users/new(.:format)        admin/users#new
#       edit_admin_user GET    /admin/users/:id/edit(.:format)   admin/users#edit
#            admin_user GET    /admin/users/:id(.:format)        admin/users#show
#                       PATCH  /admin/users/:id(.:format)        admin/users#update
#                       PUT    /admin/users/:id(.:format)        admin/users#update
#                       DELETE /admin/users/:id(.:format)        admin/users#destroy
#

X::Application.routes.draw do  
  resources :customers do
    resources :projects, shallow: true
  end
  
  concern :firm do
    resources :customers
    resources :vendors
  end
  
  resources :packages, :packaging_components, :wines, :projects, :customers, :vendors,
            :bottles, :corks, :screwcaps, :capsules, :front_labels, :back_labels, :shippers
  
  devise_for :users
  
  root "projects#index"

  namespace :admin do
    root "base#index"
    resources :users
    
  end

end
