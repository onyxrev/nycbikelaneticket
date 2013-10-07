module SessionSpecHelper
  def login_with_existing_plaintiff
    create_plaintiff

    visit new_session_path

    fill_in "Email",       with: "cams@inter.net"
    fill_in "Postal code", with: "10001"

    click_on "Log in"
  end

  def create_plaintiff
    Plaintiff.create({
      :email       => "cams@inter.net",
      :postal_code => "10001",
      :fullname    => "Carlos Danger",
      :country     => "United States"
    })
  end
end
