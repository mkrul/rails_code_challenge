Rails.application.routes.draw do
  resources :lists
  get "/lists/:id/add_task", to: "lists#add_task", as: "add_task"
  put "/lists/:id/toggle_complete", to: "lists#toggle_complete", as: "toggle_complete"
  root "lists#index"

  resources :tasks
  put "/tasks/:id/toggle_completion", to: "tasks#toggle_completion", as: "toggle_completion"
end

