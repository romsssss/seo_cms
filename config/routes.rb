SeoCms::Engine.routes.draw do
  resources :articles, path: 'seo_content', only: [:index, :new, :create, :edit, :update, :destroy]
  SeoCms::DynamicRouter.load
end
