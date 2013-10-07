require 'spec_helper'

describe Ticket do
  describe "#to_hash" do
    it "returns a hash of useful data" do
      plaintiff_fullname =  "Michael Capello"

      ticket_data = {
        :created_at => Time.now,
        :date       => Date.today,
        :latitude   => 40.551042,
        :longitude  => -74.05663
      }

      plaintiff = Plaintiff.create(:fullname => plaintiff_fullname, :postal_code => "10001", :email => "zip@zip.com", :country => "United States")
      ticket = plaintiff.tickets.new(ticket_data)

      ticket.to_hash.should == ticket_data.merge(:fullname => plaintiff_fullname)
    end
  end
end
