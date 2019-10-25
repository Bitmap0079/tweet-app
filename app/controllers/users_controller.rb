class UsersController < ApplicationController
  before_action :authenticate_user, {only:[:index, :show, :edit, :update]}
  before_action :forbid_login_user, {only:[:new, :create, :login_form, :login]}
  before_action :ensure_correct_user, {only:[:edit, :update, :destroy]}
  def index
    @users = User.all.order(created_at: :desc)
  end
  
  def show
    @user = User.find_by(id: params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password]
      )
    if @user.save
      session[:user_id] = @user.id
      redirect_to "/users/#{@user.id}"
      flash[:notice] = "ユーザーを作成しました"
    else
      render "users/new"
    end
  end
  
  def edit
    @user = User.find_by(id: params[:id])
  end
  
  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    if @user.save
      redirect_to "/users/#{@user.id}"
      flash[:notice] = "ユーザー情報が編集されました"
    else
      render "users/edit" #renderはURLではなく
                          #render("フォルダ名/ファイル名")にして表示したいビューを指定する
    end
  end
  
  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
  end
  
  def login_form
  end
  
  def login
    @user = User.find_by(
      email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to "/posts/index"
      flash[:notice] = "ログインしました"
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render "users/login_form"
    end
  end
  
  def logout
    session[:user_id] = nil
    redirect_to "/login"
    flash[:notice] = "ログアウトしました"
  end
  
  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      redirect_to "/posts/index"
      flash[:notice] = "権限がありません"
    end
  end
end
