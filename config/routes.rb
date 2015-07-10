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
  # resources :customers
  
  devise_for :users
  
  resources :customers do
    resources :projects, shallow: true
    resources :wine_shipments
    resources :sampled_wines
  end
  
  resources :vendors do
    resources :bottles, shallow: true
  end
  
  # resources :projects, only: [:index, :show, :edit, :update]
  
  get "/clear-comment/:comment_id/from-project/:project_id", controller: "comments", action: "complete_action"
  get "/projects/:id/component/:component", controller: "projects", action: "show_component", as: :show_project_component
  get "/projects/:id/spec_sheet", controller: "projects", action: "show_spec_sheet", as: :spec_sheet
  
  put "/bottles", controller: "bottles", action: "update"
  
  post "/clear-project-comment", controller: "comments", action: "complete_action"
  get  "/comments/:id/edit", controller: "comments", action: "edit", as: :edit_comment
  put  "/comments/:id/update", controller: "comments", action: "update", as: :update_comment
  get  "/projects/:id/clone", controller: "projects", action: "clone", as: :clone_project
  post "/firms/:firm_id/attribute/:attr/update", controller: "firms", action: "update_firm_attribute", as: :update_firm_attribute
  
  # concern :firm do
  #   resources :customers
  #   resources :vendors
  # end
  
  resources :wine_shipments
  
  resources :purchase_orders
  resources :packaging_component_orders, only: [:create, :update, :destroy]
  
  resources :wines do
    resources :components
    resources :wine_shipments
    resources :reviewers
  end
  
  resources :packaging_components, :bottles, :corks, :screwcaps, :capsules, :front_labels, 
            :back_labels, :vendors, :comments
            
  resources :projects do
    resources :comments
  end
  
  resources :users do
    resources :comments
  end
  
  
  
  
  get "/projects/:id/remove/:association", to: "projects#remove", as: :remove_component
  
  root "projects#index"

  namespace :admin do
    root "base#index"
    resources :users
    
  end

end
