module TicketSpecHelper
  def choose_datepicker(datepicker_selector, day)
    within(datepicker_selector) do
      page.all("input.datetime").first.click
    end

    within ".datepicker.dropdown-menu" do
      page.should have_content "Su"
      page.should have_content "Mo"
      find("td", :text => day).click
    end
  end

  def choose_timepicker(timepicker_selector, time)
    within(timepicker_selector) do
      page.all("input.datetime").last.click
    end

    within ".timepicker.dropdown-menu" do
      page.should have_content "00:00"
      find("a", :text => time).click
    end
  end
end
