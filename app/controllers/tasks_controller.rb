class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = current_user.tasks.all.page(params[:page]).per(10)
  end

  def show
    @task = Task.find(params[:id])
  end
  
  # new → create
  def new
    # Task っていうのは、モデル名
    # モデル名「先頭大文字」かつ「単数形」です
    # @task = Task.new
    @task = current_user.tasks.new
  end

  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
      flash[:success] = "タスクが追加されました"
      # redirect_to task(1)
      # redirect_to task(2)
      # redirect_to task(@task.id)
      # redirect_to @task
      redirect_to root_url
    else
      flash.now[:danger] = "タスクを追加できませんでした"
      render "toppages/index"
    end
  end

  # edit → update
  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to root_path
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    flash[:success] = 'タスクは正常に削除されました'
    # サイトを開く → http://techacademy-kouichiroukimura.c9users.io:8080/tasks
    # redirect_to http://techacademy-kouichiroukimura.c9users.io:8080/tasks
    redirect_back(fallback_location: root_path)
  end

  private 

  # これは、あくまでメソッド名なので、特に指定はありません
  # ただし、Ruby のメソッド名に先頭大文字を使うことはありません！
  def task_params
    params.require(:task).permit(:content, :status)
  end

  def correct_user
    # current_user ... 今、ログインしているユーザー
    # current_user.tasks ... 今、ログインしているユーザーのタスク一覧
    # current_user.tasks.find_by ... 「今、ログインしているユーザーのタスク一覧」中に id があるか？
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end

end