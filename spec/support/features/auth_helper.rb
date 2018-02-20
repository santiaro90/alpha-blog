module Features
  module AuthHelpers
    def login_as(user, pass)
      visit login_path

      fill_in 'Email', with: user.email
      fill_in 'Password', with: pass

      click_button 'Log in'
    end
  end
end
