class SessionsController < ApplicationController
  
  def new
    # print " cnwA", User.count
    @title = "Sign in"
  end
  
  def create
    # print " csvA", User.count
    user, msg = User.authenticate(params[:session][:email], 
                                params[:session][:password])
    # user = usermsg[0]
    # msg  = usermsg[1]
    if user.nil? 
      flash.now[:error] = "Invalid email/password combination. " + msg
      @title = "Sign in"
      render 'new'
    else 
      sign_in user
      redirect_back_or user
    end
  end
  
  def destroy
      # print " csoA", User.count
    sign_out
      # print " csoB", User.count
    redirect_to root_path
      # print " csoC", User.count
  end

end
