class UsersController < ApplicationController

  def index
    @users = User.all
  end
  def create
    if User.create(resource_params)
      redirect_to :action => 'index'
    end
  end
  def edit
    @user = User.find(params[:id])
  end
  def show
    @user = User.find(params[:id])
  end
  def new
    @user = User.new
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update!(resource_params)
      redirect_to :action => 'index'
    end
  end
  def destroy
    if User.destroy(params[:id])
      redirect_to :action => 'index'
    end
  end

  private

  def resource_params
    params.require(:user).permit(:name, :age)
  end
  def authenticate
    authenticate_or_request_with_http_digest do |username|
      USERS[username]
    end
  end

  before_filter :authenticate_user!, except:[:index,:profile]

  def index
  end

  #Show
  def profile  
    @user = User.find(params[:id]) 
  end
end
