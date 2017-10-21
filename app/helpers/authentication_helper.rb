module AuthenticationHelper
  def login_user(user)
    return_to = session[:return_to]
    reset_session
    session[:user_id] = user.id
    session[:return_to] = return_to
  end
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  def logged_in?
    !current_user.nil?
end
def log_out
reset_session
end

def login_required
  unless logged_in?
    store_target_location
    flash[:warning] = 'Zaloguj sie aby uzyskać dostęp.'
    redirect_to login_path
end
end

def redirect_to_target_or_root
redirect_to(session[:return_to] || root_path)
session[:return_to] = nil
end


private
def store_target_location
  session[:return_to] = request.url
end
end
