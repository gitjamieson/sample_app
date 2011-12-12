class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

  def new
    @user = User.new
    @title = "Sign up"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      flash[:error] = "this is a test of an 'error' flash label to produce a different color box then the 'success' box based on the predefined CSS for a type error verses type success for each class.  You need to look at the layout/application.erb, as this is displaying the flash and create the <div class  lines"
      flash[:info] = "this is a test of an 'info' flash label to produce a different color box then the success box based on the predefined CSS" 
      flash[:notice] = "look in: public/stylesheets/blueprint/screen.css. Youll find CSS values for .error, .alert, .success .. etc which define the box and color"

      redirect_to @user
    else
      @title = "Sign up"
      @user.password=""
      @user.password_confirmation=""
      render 'new'
    end
  end

end
