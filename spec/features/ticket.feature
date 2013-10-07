require 'spec_helper'

describe "ticket creation with no plaintiff" do
  it "redirects to the new plaintiff page" do
    visit new_ticket_path

    current_path.should == new_plaintiff_path
  end
end

describe "ticket creation" do
  before(:each) do
    login_with_existing_plaintiff
    visit new_ticket_path
  end

  it "rejects empty ticket data" do    
    click_on "Create Ticket"

    within ".control-group.ticket_number" do
      page.should have_content "can't be blank"
    end

    within ".control-group.ticket_location" do
      page.should have_content "can't be blank"
    end

    within ".control-group.ticket_date" do
      page.should have_content "can't be blank"
    end
  end

  it "rejects some wonky data" do
    fill_in "Ticket Number", with: "@@91991CrazyGlue"

    click_on "Create Ticket"

    within ".control-group.ticket_number" do
      page.should have_content "is invalid"
    end
  end

  it "conducts a google maps search of a valid location" do
    fill_in "Enter the location", with: "30 Rockefeller Plaza"
    fill_in "Officer number",     with: "666"

    page.should have_content "Looks like we may have found your ticket location."
  end

  it "conducts a google maps search of an invalid location" do
    fill_in "Enter the location", with: "7th Circle of Hell, Ballsqueek, Neptune"
    fill_in "Officer number",     with: "666"

    page.should have_content "We weren't able to find that ticket location."
  end

  it "creates a ticket from the minimum required data" do
    fill_in "Ticket Number",          with: "AAU1234567"
    fill_in "Enter the location",     with: "Brooklyn, NY"

    choose_datepicker(".control-group.ticket_date", "21")
    choose_timepicker(".control-group.ticket_date", "03:00")

    click_on "Create Ticket"

    page.should have_content "Your ticket has been recorded"
  end

  it "creates a ticket from full data" do
    fill_in "Ticket Number",          with: "AAU1234563"
    fill_in "How much was your fine", with: "99"
    fill_in "additional expenses",    with: "1"
    fill_in "Enter the location",     with: "Brooklyn, NY"

    choose_datepicker(".control-group.ticket_date", "21")
    choose_timepicker(".control-group.ticket_date", "03:00")

    fill_in "Officer number", with: "666"

    choose_datepicker(".control-group.ticket_hearing_date", "21")
    choose_timepicker(".control-group.ticket_hearing_date", "03:00")

    select 'Guilty', from: 'Hearing verdict'

    choose_datepicker(".control-group.ticket_appeal_date", "21")
    choose_timepicker(".control-group.ticket_appeal_date", "03:00")

    select 'Guilty', from: 'Appeal verdict'

    fill_in "Anything else", with: "I was preparing for a turn when I was swarmed by swerving bikers, pushcarts, NYPD squad cars, trash, a fallen tree, glass, opening doors, pedestrians hailing a cab, the cab, and two mating yetis while inside the bike lane."

    click_on "Create Ticket"

    page.should have_content "Your ticket has been recorded"
  end

  it "will show on the homepage if the plaintiff has the public preference" do
    Plaintiff.first.update_attributes(:is_public => true)

    fill_in "Ticket Number",          with: "AAU1234568"
    fill_in "Enter the location",     with: "Brooklyn, NY"

    choose_datepicker(".control-group.ticket_date", "21")
    choose_timepicker(".control-group.ticket_date", "03:00")

    click_on "Create Ticket"

    page.should have_content "Your ticket has been recorded"   

    visit root_path

    page.should have_content "Carlos Danger"
  end

  it "will not show on the homepage if the plaintiff doesn't have the public preference" do
    Plaintiff.first.update_attributes(:is_public => false)

    fill_in "Ticket Number",          with: "AAU1234569"
    fill_in "Enter the location",     with: "Brooklyn, NY"

    choose_datepicker(".control-group.ticket_date", "21")
    choose_timepicker(".control-group.ticket_date", "03:00")

    click_on "Create Ticket"

    page.should have_content "Your ticket has been recorded"   

    visit root_path

    page.should_not have_content "Carlos Danger"
  end
end