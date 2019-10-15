class UsersController < ApplicationController
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
    @user = User.new(name: params[:name], email: params[:email])
    if @user.save
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
    redirect_to "/users/index"
    flash[:notice] = "ユーザー情報が削除されました"
  end
end
