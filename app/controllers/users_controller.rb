class UsersController < ApplicationController

  def show
    @title = "Show User"
    @user = User.find(params[:id])
  end

  def new
    @title = "Sign up"
  end

end
