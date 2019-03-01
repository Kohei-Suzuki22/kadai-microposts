class UsersController < ApplicationController
  
  before_action :require_user_logged_in, only: [:index,:show, :followings, :followers,:likes]
  before_action :dry_user_find, only: [:show,:followings, :followers, :likes]
  
  def index
    @users = User.all.page(params[:page])
  end

  def show
    # @user = User.find(params[:id])
    @microposts = @user.microposts.order("created_at DESC").page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "ユーザを登録しました。"
      redirect_to @user
    else
      # binding.pry
      flash.now[:danger] = "ユーザーの登録に失敗しました。"
      render :new
    end
    
  end
  
  def followings 
    # @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end 
  
  def followers 
    # @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end 
  
  def likes 
    # @user = User.find(params[:id])
    @favorites = @user.favo_microposts.page(params[:page])
    counts(@user)
  end
  
  private
  
  def dry_user_find
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
end
