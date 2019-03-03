class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy, :new_list_task, :toggle_complete]

  # GET /lists
  # GET /lists.json
  def index
    @lists = List.all
    @misc_tasks = Task.where(list_id: nil)
  end

  # GET /lists/1
  # GET /lists/1.json
  def show
  end

  # GET /lists/new
  def new
    @list = List.new
  end

  # GET /lists/1/edit
  def edit
  end

  def new_list_task
    @task = Task.new
  end

  # POST /lists
  # POST /lists.json
  def create
    @list = List.new(list_params)

    respond_to do |format|
      if @list.save
        format.html { redirect_to lists_path, notice: "List was successfully created." }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lists/1
  # PATCH/PUT /lists/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to @list, notice: "List was successfully updated." }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    @list.tasks.each do |task|
      task.destroy
    end
    @list.destroy
    respond_to do |format|
      format.html { redirect_to lists_url, notice: "List was successfully deleted." }
      format.json { head :no_content }
    end
  end

  def toggle_complete
    @list.update(status: @list.new_status, completed_at: @list.new_completed_at_time)
    @list.tasks.each do |task|
      task.update(status: @list.status, completed_at: @list.completed_at)
    end

    respond_to do |format|
      format.html { redirect_to lists_url, notice: "List was marked as #{@list.status}." }
      format.json { render :index, status: ok }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def list_params
      params.require(:list).permit(:title)
    end
end
