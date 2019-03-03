json.extract! subtask, :id, :title, :created_at, :updated_at
json.url subtask_url(subtask, format: :json)
