Rails.application.routes.draw do
  # Respond to all paths with hello#index
  match '*path', to: 'hello#index', via: :all
  root 'hello#index'
end

