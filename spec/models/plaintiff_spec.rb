require 'spec_helper'

describe Plaintiff do
  describe "auth methods" do
    before(:each) do
      @email       = "scofflaw.biker@bike_messengers.net"
      @postal_code = "10001"
      @auth_string = "zomg"
      @md5_hash    = "md5 hash yay"
    end

    describe "#self.generate_auth_hash" do
      it "generates the auth string" do
        Plaintiff.should_receive(:auth_string).with(@email, @postal_code)
        Digest::MD5.stub(:hexdigest)

        Plaintiff.generate_auth_hash(@email, @postal_code)
      end

      it "creates an MD5 hash the email and postal code" do
        Plaintiff.stub(:auth_string).and_return(@auth_string)
        Digest::MD5.should_receive(:hexdigest).with(@auth_string).and_return(@md5_hash)

        Plaintiff.generate_auth_hash(@email, @postal_code).should == @md5_hash
      end
    end

    describe "#self.for_email_and_postal_code" do
      it "generates an auth hash for the lookup" do
        Plaintiff.should_receive(:generate_auth_hash).with(@email, @postal_code)
        Plaintiff.stub(:where).and_return(double(:first => nil))

        Plaintiff.for_email_and_postal_code(@email, @postal_code)
      end

      it "finds the first Plaintiff with the auth hash" do
        plaintiff = double

        Plaintiff.stub(:generate_auth_hash).and_return(@md5_hash)
        Plaintiff.should_receive(:where).with(:auth_hash => @md5_hash).and_return(double(:first => plaintiff))

        Plaintiff.for_email_and_postal_code(@email, @postal_code).should == plaintiff
      end
    end
  end

  describe "#to_hash" do
    it "returns a hash of useful keys" do
      fullname    = "Michael Capello"
      created_at = Time.now

      plaintiff = Plaintiff.new(:fullname => fullname, :created_at => created_at)

      plaintiff.to_hash.should == { :fullname => fullname, :created_at => created_at }
    end
  end
end
