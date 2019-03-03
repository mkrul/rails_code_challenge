class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :toggle_completion]
  before_action :check_misc_tasks_list

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    # TODO: refactor this
    unless List.any?
      default_list = List.create(title: "My List")
    end
    first_list_title = default_list.present? ? default_list.title : List.last.title
    @task = Task.new
    @list_titles = [first_list_title, List.all.map(&:title)].flatten.uniq
  end

  # GET /tasks/1/edit
  def edit
    # TODO: refactor this
    unless List.any?
      default_list = List.create(title: "My List")
    end
    first_list_title = default_list.present? ? default_list.title : List.last.title
    @list_titles = [first_list_title, List.all.map(&:title)].flatten.uniq
  end

  # POST /tasks
  # POST /tasks.json
  def create
    if params[:commit] == "New Task"
      list_id = List.find_by_title(params[:task][:list_title]).id
    else # Adding a task to a list
      list_id = params[:task][:list_id]
    end

    task_params = Task.format_params(params[:task][:title], params[:task][:description], list_id)  
    respond_to do |format|
      if @task = Task.create(task_params)
        format.html { redirect_to lists_url, notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    list = List.find_by_title(params[:task][:list_title])
    task_params = Task.format_params(params[:task][:title], params[:task][:description], list.id)
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to lists_url, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to lists_url, notice: "Task was successfully deleted." }
      format.json { head :no_content }
    end
  end

  def toggle_completion
    @task.update(status: @task.new_status, completed_at: @task.new_completed_at_time)
    list = List.find(@task.list_id)

    if list.tasks.all?(&:completed_at)
      list.update(status: List::STATUS_COMPLETE, completed_at: @task.completed_at)
    else
      list.update(status: List::STATUS_PENDING, completed_at: nil)
    end
    respond_to do |format|
      format.html { redirect_to lists_url, notice: "Task was marked as #{@task.status}." }
      format.json { render :index, status: ok }
    end  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :description, :list_id, :list_title)
    end
end
