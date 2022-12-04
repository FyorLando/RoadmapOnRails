class UserController < ApplicationController


  def show
    ans = User.all
    render :json => ans
  end

  def create
    user = User.create(name: "David", occupation: "Code Artist")
  end


end
