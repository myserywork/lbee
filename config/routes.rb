Rails.application.routes.draw do

  root 'counterdown#index'

  get 'busca/:type', to: 'friend#index'
  post 'busca/:type', to: 'friend#index'

  get 'invite/:to', to: 'friend#invite'

  get 'amigo/confirmation/:token', to: 'friend#confirmation'

  get 'machine/index'

  get 'machine/create'

  get 'machine/dashboard'

  get 'machine/news'

  get '/machine/createnews', to: 'machine#newscreate'

  #root 'welcome#index'
  get '/game/:jogo', to: 'welcome#index'

  get 'outros/index'
  get 'outros/:jogo', to: 'outros#index'
  get 'outros', to: 'outros#index'

  get 'videos/index'
  get 'videos/:jogo', to: 'videos#index'
  get 'videos', to: 'videos#index'

  get 'news/index'
  get 'noticias/:jogo', to: 'news#index'
  get 'noticias', to: 'news#index'

  get 'noticias/:jogo/:id', to: 'news#show'
  get 'noticias/:id', to: 'news#show'

  get 'championship/index'
  get 'campeonatos/:jogo', to: 'championship#index'
  get 'campeonatos', to: 'championship#index'

  get 'ranking/index'
  get 'ranking/:game', to: 'ranking#index'
  get 'ranking', to: 'ranking#index'

  get 'contato/index'
  get 'contato', to: 'contato#index'

  get 'quemsomos/index'
  get 'quemsomos', to: 'quemsomos#index'

  get 'team/index'
  get 'team/:team_name', to: 'team#index'
  get 'team/edit/:team_name', to: 'team#edit'
  post 'team/edit/:team_name', to: 'team#edit'
  get 'team/conf/:team_name', to: 'team#conf'
  post 'team/conf/:team_name', to: 'team#conf'
  get '/cadastro_time', to: 'team#signup'
  post '/cadastro_time', to: 'team#signup'
  get 'team/confirmation/:token', to: 'team#confirmation'
  get 'team/userconfirmation/:token', to: 'team#userconfirmation'
  get 'team/invite/:to/:team_id', to: 'team#invite'
  get 'myteam', to: 'team#user'

  get 'user/index'
  get 'user/:user_nick', to: 'user#index'
  get 'mymessages', to: 'message#index'
  get 'user/messages/:to', to: 'message#show'
  post 'user/messages/:to', to: 'message#show'
  get 'user', to: 'user#index'
  get 'user/forget/:token', to: 'user#forgetpass'
  post 'user/forget/:token', to: 'user#forgetpass'
  get 'repassword', to: 'user#forget'
  post 'repassword', to: 'user#forget'

  get '/edit', to: 'user#edit'
  post '/edit', to: 'user#edit'
  get 'user/signup'
  get '/cadastro', to: 'user#signup'
  post '/cadastro', to: 'user#signup'
  get 'user/confirmation/:token', to: 'user#confirmation'

  post '/login', to: 'user#signin'
  get '/logout', to: 'user#logout'

  match '/auth/:provider/callback', to: 'user#auth_callback', via: :all

  namespace :api do
    namespace :v1 do

      resources :pusher do
        collection do
          post :auth
        end
      end

    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
