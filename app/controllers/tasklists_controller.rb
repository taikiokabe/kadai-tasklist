class TasklistsController < ApplicationController
   before_action :require_user_logged_in
   before_action :correct_user, only: [:destroy]

  def create
    @tasklist = current_user.tasklists.build(tasklist_params)
    if @tasklist.save
      flash[:success] = 'タスクを登録しました。'
      redirect_to root_url
    else
      @tasklists = current_user.tasklists.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'タスクの登録に失敗しました。'
      render 'toppages/index'
    end
  end
  
  def edit
    set_tasklist
  end

  def destroy
    set_tasklist
    @tasklist.destroy
    flash[:success] = 'タスクを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  def update
    set_tasklist
    if @tasklist.update(tasklist_params)
      flash[:success] = 'タスクが正常に更新されました'
      redirect_to root_url
    else
      @tasklists = current_user.tasklists.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'タスクが更新されませんでした'
      render 'toppages/index'
    end
  end

  private
  
  def set_tasklist
    @tasklist = Tasklist.find(params[:id])
  end

  def tasklist_params
    params.require(:tasklist).permit(:content,:status)
  end
  
  def correct_user
    @tasklist = current_user.tasklists.find_by(id: params[:id])
    unless @tasklist
      redirect_to root_url
    end
  end
end