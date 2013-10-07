require 'spec_helper'

describe "plaintiff registration" do
  it "loads from homepage" do
    visit root_path

    click_on "Join the Class Action"
    
    page.should have_content "Register as a Plaintiff"
    current_path.should == new_plaintiff_path
  end

  it "rejects empty plaintiff data" do
    visit new_plaintiff_path

    click_on "Create Plaintiff"

    within ".control-group.plaintiff_fullname" do
      page.should have_content "can't be blank"
    end

    within ".control-group.plaintiff_postal_code" do
      page.should have_content "can't be blank"
    end

    within ".control-group.plaintiff_country" do
      page.should have_content "can't be blank"
    end

    within ".control-group.plaintiff_email" do
      page.should have_content "can't be blank"
    end
  end

  it "rejects and filters some invalid data" do
     visit new_plaintiff_path

     fill_in "Email",       with: "theNYPDparksinbikelanesforDonutruns"
     fill_in "Postal code", with: "superlongpostalcode111!"
     fill_in "Phone",       with: "111222-222-222%"     

     click_on "Create Plaintiff"

     within ".control-group.plaintiff_email" do
       page.should have_content "is invalid"
     end

     within ".control-group.plaintiff_postal_code" do
       page.should have_content "is too long"
     end

     within ".control-group.plaintiff_phone" do
       page.find("input").value.should == "111222222222"
     end   
  end

  it "registers a plaintiff with the bare minimums and redirects to the new ticket page" do
    visit new_plaintiff_path

    fill_in "Full name",    with: "Law Abiding Cyclist"
    fill_in "Email",        with: "i_heart_brooklynspoke@example.com"
    fill_in "Postal code",  with: "10001"
    select 'United States', from: 'Country'

    click_on "Create Plaintiff"

    current_path.should == new_ticket_path
  end

  it "registers a plaintiff with a full profile and redirects to the new ticket page" do
    visit new_plaintiff_path

    fill_in "Full name",        with: "Law Abiding Cyclist"
    fill_in "Street address",   with: "30 Rockefeller Plaza"
    fill_in "Unit / apartment", with: "Floor 12"
    fill_in "Postal code",      with: "10001"
    fill_in "Email",            with: "i_heart_brooklynspoke@example.com"
    fill_in "Phone",            with: "718-222-1111"
    
    within ".plaintiff_is_public" do
      choose 'Yes'
    end

    select 'United States',     from: 'Country'

    click_on "Create Plaintiff"

    current_path.should == new_ticket_path
  end

  it "cancels to the home page" do
    visit new_plaintiff_path

    click_on "Cancel"

    page.should have_content "Join the Class Action"
    current_path.should == root_path
  end  

  it "can direct to the login page" do
    visit new_plaintiff_path

    click_on "Log in"

    current_path.should == new_session_path
  end
end