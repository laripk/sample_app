module SessionsHelper
  
  def sign_in(user)
    # print " si", User.count
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    self.current_user = user
  end
  
  def sign_out
    # print " so", User.count
    cookies.delete(:remember_token)
    self.current_user = nil
  end
  
  def current_user=(user)
    # print " cueA", User.count
    @current_user = user
  end
  
  def current_user
    # print " cu", User.count
    @current_user ||= user_from_remember_token
  end
  
  def signed_in?
    # print " siq", User.count
    # print "signed in user = '" + current_user.inspect + "'"
    !current_user.nil?
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def deny_access
    store_location
    redirect_to signin_path, :notice => "Please sign in to access this page."
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end
  
  private
    
    def user_from_remember_token
      # print " ufrt", User.count
      User.authenticate_with_salt(*remember_token)
    end
    
    def remember_token
      # print " rt", User.count
      cookies.signed[:remember_token] || [nil, nil]
    end
  
    def store_location
      session[:return_to] = request.fullpath
    end
    
    def clear_return_to
      session[:return_to] = nil
    end
  
end
