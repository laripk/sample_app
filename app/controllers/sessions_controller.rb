class SessionsController < ApplicationController
  
  def new
    print " cA", User.count
    @title = "Sign in"
  end
  
  def create
    usermsg = User.authenticate(params[:session][:email], 
                                params[:session][:password])
    user = usermsg[0]
    msg  = usermsg[1]
    if user.nil? 
      flash.now[:error] = "Invalid email/password combination. " + msg
      @title = "Sign in"
      render 'new'
    else 
      sign_in user
      redirect_to user
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end

end
