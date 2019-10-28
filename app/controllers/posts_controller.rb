class PostsController < ApplicationController
  before_action :authenticate_user, {only:[:index, :show, :edit, :update]}
  before_action :ensure_correct_user, {only:[:edit, :update, :destroy]}
  
  def index
    @posts = Post.all.order(created_at: :desc)
  end
  
  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(
      content: params[:content],
      user_id: @current_user.id,
      user_name: @current_user.name
      )
    if @post.save
      redirect_to "/posts/index"
      flash[:notice] = "投稿が作成されました"
    else
      render "posts/new"
    end
  end
  
  
  def edit
    @post = Post.find_by(id: params[:id])
  end
  
  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      redirect_to "/posts/index"
      flash[:notice] = "投稿が編集されました"
    else
      render "posts/edit" #renderはURLではなく
                          #render("フォルダ名/ファイル名")にして表示したいビューを指定する
    end
  end
  
  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to "/posts/index"
    flash[:notice] = "投稿が削除されました"
  end
  
  def ensure_correct_user
      @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      redirect_to "/posts/index"
      flash[:notice] = "権限がありません"
    end
  end
end
