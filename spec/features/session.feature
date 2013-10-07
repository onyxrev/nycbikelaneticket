require 'spec_helper'

describe "session" do
  before(:each) do
    create_plaintiff
    visit new_session_path
  end

  it "logs in a known plaintiff" do
    login_with_existing_plaintiff

    page.should have_content "You've been logged in"
    current_path.should == new_ticket_path
  end

  it "handles empty data" do
    click_on "Log in"

    page.should have_content "couldn't find a plaintiff record"
  end

  it "doesn't log in an unknown plaintiff" do
    fill_in "Email",       with: "whoosat@inter.net"
    fill_in "Postal code", with: "10002"
 
    click_on "Log in"

    page.should have_content "couldn't find a plaintiff record"
  end
end

