module FeatureHelper
def login_user(user)
  visit root_path
  click 'Logowanie'
  fill_in 'Adres email', with: user.email
  fill_in 'Hasło', with: user.password
  click_button 'Zaloguj sie'
end
end
