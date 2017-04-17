class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  def show
    @task = Task.find(params[:id])
  end
  def new
    @task = Task.new
  end
  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = 'taskが正常に登録されました'
      redirect_to @task
    else
      flash.now[:danger] = 'taskが登録できません'
      render :new
    end
  end
  def edit
    @task = Task.find(params[:id])
  end
  def update
    @task = Task.find(prams[:id])
    
    if @task.update(task_params)
      flash[:success] = 'taskは正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'taskは更新されませんでした'
      render :edit
    end
  end
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = 'taskは正常に削除されました'
    redirect_to tasks_url
  end
end

private
# Strong Parameter
def task_params
  params.require(:task).permit(:content, :status)
end
