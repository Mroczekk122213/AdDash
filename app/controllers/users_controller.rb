class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if !verify_recaptcha
  flash.now[:danger] = 'Uzupełnij reCAPTCHA.'
  render :new
  elsif @user.save
  flash[:success] = 'Zostałeś zarejestrowany.'
  redirect_to root_path
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
