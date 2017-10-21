require "recaptcha/rails"
class UsersController < ApplicationController
before_action :login_required, only: :account
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if !verify_recaptcha
  flash.now[:danger] = 'Uzupełnij reCAPTCHA.'
  render :new
  elsif @user.save
  login_user(@user)
  flash[:success] = 'Zostałeś zarejestrowany.'
  redirect_to_target_or_root
  else
  flash.now[:danger] = 'Nie można utworzyć konta użytkownika.'
  render :new
end
end

private
def user_params
params.require(:user).permit(
:email, :first_name, :last_name, :password, :password_confirmation
)

end
end
