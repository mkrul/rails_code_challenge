Rails.application.routes.draw do
  resources :lists
  get "/lists/:id/add_task", to: "lists#add_task", as: "add_task"
  root "lists#index"

  resources :tasks
  put "/tasks/:id/toggle_completion", to: "tasks#toggle_completion", as: "toggle_completion"
end

