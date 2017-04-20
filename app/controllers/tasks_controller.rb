class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :destroy, :update,]
  
  def index
    @tasks = Task.all.page(params[:page]).per(3)
  end
  def show
#    @task = Task.find(params[:id])
  end
  def new
    @task = Task.new
  end
  def create
#    @task = Task.new(task_params)
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'taskが正常に登録されました'
#      redirect_to @task
      redirect_to root_url
    else
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'taskが登録できません'
      #render :new
      #render 'tasks/new'
      render 'toppages/index'
    end
  end
  def edit
#    @task = Task.find(params[:id])
#    @task = current_user.tasks.build(task_params)
  end
  def update
#    @task = Task.find(params[:id])
    
    if @task.update(task_params)
      flash[:success] = 'taskは正常に更新されました'
      redirect_to root_url
    else
      flash.now[:danger] = 'taskは更新されませんでした'
      #render : 'toppages/index'
      render :edit
    end
  end
  
  def destroy
#    @task = Task.find(params[:id])
#    @task.destroy
    
#    flash[:success] = 'taskは正常に削除されました'
#    redirect_to tasks_url
    @task.destroy
    flash[:success] = 'タスクを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end

  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_path
    end
  end
end