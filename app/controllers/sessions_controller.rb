class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      login_user(user)
      flash[:success] = 'Zostałeś zalogowany.'
      redirect_to_target_or_root
    else
      flash.now[:danger] = 'Niepoprawny email lub hasło.'
      render :new
    end
end
  def destroy
    log_out
    flash[:success] = "Zostałeś wylogowany. "
    redirect_to root_path
  end
end
