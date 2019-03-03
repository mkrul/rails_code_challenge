Rails.application.routes.draw do
  root "lists#index"

  resources :subtasks
  put "/subtasks/:id/toggle_complete_subtask", to: "subtasks#toggle_complete_subtask", as: "toggle_complete_subtask"

  resources :lists
  get "/lists/:id/new_added_task", to: "lists#new_added_task", as: "new_added_task"
  put "/lists/:id/toggle_complete", to: "lists#toggle_complete", as: "toggle_complete"

  resources :tasks
  get "/tasks/:id/new_added_subtask", to: "tasks#new_added_subtask", as: "new_added_subtask"
  put "/tasks/:id/toggle_completion", to: "tasks#toggle_completion", as: "toggle_completion"
end

