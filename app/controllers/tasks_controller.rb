class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    @tasks = Task.all.page(params[:page])
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      flash[:success] = 'タスクが正常に登録されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクが登録されませんでした'
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = 'タスクが正常に登録されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクが登録されませんでした'
      render :edit
    end
  end

 def destroy
    @micropost.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
 end
end

  private
  
  def set_task
    @task = Task.find(params[:id])
  end

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content,:status)
  end

