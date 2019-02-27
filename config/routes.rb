Rails.application.routes.draw do
  resources :tasks
  put '/tasks/:id/toggle_completion', to: 'tasks#toggle_completion', as: 'toggle_completion'
end
