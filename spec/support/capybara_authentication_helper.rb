# Provides authentication helper methods for system tests
module CapybaraAuthenticationHelper
  def signup(username:, email:, password:)
    visit new_user_registration_path

    fill_in 'Username', with: username
    fill_in 'Email',    with: email
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: password

    click_on :commit
  end

  def login(as: nil, email: nil, password: nil)
    visit new_user_session_path

    fill_in 'Email',    with: email    || as&.email
    fill_in 'Password', with: password || as&.password

    click_on :commit
  end

  def logout
    # close alert if found
    find('[data-bs-dismiss="alert"]').click if have_selector?('[data-bs-dismiss="alert"]')
    find('.dropstart').click
    click_on 'Sign out'
  end
end
