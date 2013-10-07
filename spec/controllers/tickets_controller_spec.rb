require 'spec_helper'

describe TicketsController do
  describe "#new" do
    it "requires a plaintiff" do
      session.delete(:plaintiff)
      subject.stub(:ticket_params)

      get :new
      response.should redirect_to new_plaintiff_path
    end

    it "newifies a ticket" do
      subject.stub(:ticket_params)
      subject.stub(:plaintiff_required)

      Ticket.should_receive(:new)
      get :new
    end
  end

  describe "#create" do
    before(:each) do
      @tickets       = double
      @plaintiff     = double(:tickets => @tickets)
      @ticket_params = double
    end

    it "calls ticket params" do
      subject.stub(:plaintiff_required)
      subject.instance_variable_set(:@plaintiff, @plaintiff)
      subject.should_receive(:ticket_params)

      @tickets.stub(:create)

      post :create
    end

    it "creates a ticket for the plaintiff with ticket_params" do
      subject.stub(:plaintiff_required)
      subject.instance_variable_set(:@plaintiff, @plaintiff)
      subject.stub(:ticket_params).and_return(@ticket_params)

      @tickets.should_receive(:create).with(@ticket_params)

      post :create
    end

    it "renders the new template if the ticket fails to save" do
      subject.stub(:plaintiff_required)
      subject.instance_variable_set(:@plaintiff, @plaintiff)
      subject.stub(:ticket_params).and_return(@ticket_params)

      @tickets.stub(:create)

      post :create
      response.should render_template :new
    end

    it "redirects to the new ticket path if the ticket saves" do
      subject.stub(:plaintiff_required)
      subject.instance_variable_set(:@plaintiff, @plaintiff)
      subject.stub(:ticket_params).and_return(@ticket_params)

      @tickets.stub(:create).and_return(double(:errors => []))

      post :create
      response.should redirect_to new_ticket_path
    end
  end

  describe "#index" do
    it "redirects to the root path" do
      get :index

      response.should redirect_to root_path
    end
  end
end
