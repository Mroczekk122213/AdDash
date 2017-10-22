module ControllerHelper
  def login_user(user)
	  request.session[:user_id] = user.id
  end
end
