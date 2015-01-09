class TasksController < ApplicationController
  before_action :require_user
  before_action :set_task, only: [:update, :destroy]

  def index
    tasks = Task.where(complete: false)
    @incomplete_tasks = current_user.tasks
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params.merge!(user: current_user))
    respond_to do |format|
      format.html { redirect_to tasks_path }
      format.js
    end
  end

  def update
    @task.update(task_params) if current_user == @task.user
    respond_to do |format|
      format.html { redirect_to tasks_path }
      format.js
    end
  end

  def destroy
    @task.destroy if current_user == @task.user
    respond_to do |format|
      format.html { redirect_to tasks_path }
      format.js
    end
  end

  private

  def task_params
    params.require(:task).permit!
  end

  def set_task
    @task = Task.find(params[:id])
  end

end
