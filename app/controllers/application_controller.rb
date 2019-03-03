class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def check_misc_tasks_list
    # misc_tasks are any tasks that have a nil list_id or belong to the Miscellaneous Tasks list
    misc_task_list = List.find_or_create_by(title: List::DEFAULT_TITLE)
    @misc_tasks = Task.where(list_id: nil)
    @misc_tasks += misc_task_list.tasks
    @misc_tasks.each do |task|
      task.update(list_id: misc_task_list.id)
    end
  end

end
