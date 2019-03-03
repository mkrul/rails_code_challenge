Rails.application.routes.draw do
  root "lists#index"
  resources :lists
  get "/lists/:id/new_list_task", to: "lists#new_list_task", as: "new_list_task"
  put "/lists/:id/toggle_complete", to: "lists#toggle_complete", as: "toggle_complete"

  resources :tasks
  put "/tasks/:id/toggle_completion", to: "tasks#toggle_completion", as: "toggle_completion"
end

