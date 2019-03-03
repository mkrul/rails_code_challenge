class SubtasksController < ApplicationController
  before_action :set_subtask, only: [:show, :edit, :update, :destroy, :toggle_complete_subtask]

  # GET /subtasks
  # GET /subtasks.json
  def index
    @subtasks = Subtask.all
  end

  # GET /subtasks/1
  # GET /subtasks/1.json
  def show
  end

  # GET /subtasks/new
  def new
    @subtask = Subtask.new
    @task = Task.find(params[:task_id])
  end

  # GET /subtasks/1/edit
  def edit
    @task = @subtask.task
  end

  # POST /subtasks
  # POST /subtasks.json
  def create
    @subtask = Subtask.new(subtask_params)

    respond_to do |format|
      if @subtask.save
        format.html { redirect_to task_path(@subtask.task), notice: "Subtask was successfully created." }
        format.json { render :show, status: :created, location: @subtask }
      else
        format.html { render :new }
        format.json { render json: @subtask.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subtasks/1
  # PATCH/PUT /subtasks/1.json
  def update
    respond_to do |format|
      if @subtask.update(subtask_params)
        format.html { redirect_to task_path(@subtask.task), notice: "Subtask was successfully updated." }
        format.json { render :show, status: :ok, location: @subtask }
      else
        format.html { render :edit }
        format.json { render json: @subtask.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subtasks/1
  # DELETE /subtasks/1.json
  def destroy
    @subtask.destroy
    respond_to do |format|
      format.html { redirect_to task_path(@subtask.task), notice: "Subtask was successfully deleted." }
      format.json { head :no_content }
    end
  end

  def toggle_complete_subtask
    @subtask.update(status: @subtask.new_status, completed_at: @subtask.new_completed_at_time)
    
    task = @subtask.task
    subtasks = task.subtasks
    tasks = @subtask.task.list.tasks

    if subtasks.all?(&:status) == @subtask.status
      task.update(status: @subtask.status, completed_at: @subtask.completed_at)
    end
    respond_to do |format|
      format.html { redirect_to task }
      format.json { render :index, status: ok }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subtask
      @subtask = Subtask.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subtask_params
      params.require(:subtask).permit(:title, :description, :task_id, :list_id)
    end
end
