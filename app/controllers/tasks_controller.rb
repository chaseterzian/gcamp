class TasksController < ApplicationController

  before_filter :authenticate_user

  before_action do
    @project = Project.find(params[:project_id])
  end


  def index
    @tasks = @project.tasks.all
  end

  def new
    @task = @project.tasks.new
  end

  def create
    @task = @project.tasks.new(task_params)
    if @task.save
      flash[:message] = "Task was successfully created"
      redirect_to project_task_path(@project, @task)
    else
      render :new
    end
  end

  def edit
    @task = @project.tasks.find(params[:id])
    @task_edit_for_partial = @project.tasks.find(params[:id])
  end

  def show
    @task = @project.tasks.find(params[:id])
    @taskdate = @project.tasks.find(params[:id])
  end

  def update
    @task = @project.tasks.find(params[:id])
    if @task.update(task_params)
      flash[:message] = "Task was successfully updated"
      redirect_to project_task_path(@project, @task)  ##removed s togoto show
    else
      render :edit
    end
  end


  def destroy
    Task.destroy(params[:id])
    flash[:message] = "Task was successfully deleted"
    redirect_to project_tasks_path(@project)
  end


  private


  def task_params
    params.require(:task).permit(:description, :complete, :due_date, :project_id)
  end

end
