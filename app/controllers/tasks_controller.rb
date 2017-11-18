class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end
  
  # new → create
  def new
    # Task っていうのは、モデル名
    # モデル名「先頭大文字」かつ「単数形」です
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    
    if @task.save
      flash[:success] = "ちゃんと追加されました"
      # redirect_to task(1)
      # redirect_to task(2)
      # redirect_to task(@task.id)
      # redirect_to @task
      redirect_to @task
    else
      flash.now[:danger] = "追加できませんでした"
      render :new
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
      redirect_to @task
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    flash[:success] = 'Task は正常に削除されました'
    # サイトを開く → http://techacademy-kouichiroukimura.c9users.io:8080/tasks
    # redirect_to http://techacademy-kouichiroukimura.c9users.io:8080/tasks
    redirect_to tasks_url
  end

  private 

  # これは、あくまでメソッド名なので、特に指定はありません
  # ただし、Ruby のメソッド名に先頭大文字を使うことはありません！
  def task_params
    params.require(:task).permit(:content)
  end
end