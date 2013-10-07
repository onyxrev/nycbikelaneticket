require 'spec_helper'

describe PlaintiffsController do
  describe "#new" do
    it "newifies a Plaintiff" do
      Plaintiff.should_receive(:new)
      get :new
    end
  end

  describe "#create" do
    it "calls plaintiff_params" do
      subject.should_receive(:plaintiff_params).and_return(nil)
      Plaintiff.stub(:create)

      post :create
    end

    it "creates a plaintiff with plaintiff params" do
      plaintiff_params = double
      subject.stub(:plaintiff_params).and_return(plaintiff_params)
      Plaintiff.should_receive(:create).with(plaintiff_params)

      post :create
    end

    it "renders :new if plaintiff fails to save" do
      subject.stub(:plaintiff_params)
      Plaintiff.stub(:create)

      post :create
      response.should render_template :new
    end

    it "saves the plaintiff to the session if it's created" do
      plaintiff = double(:errors => [])

      subject.stub(:plaintiff_params)
      Plaintiff.stub(:create).and_return(plaintiff)

      post :create
      session[:plaintiff].should == plaintiff
    end

    it "redirects to the new ticket path" do
      plaintiff = double(:errors => [])

      subject.stub(:plaintiff_params)
      Plaintiff.stub(:create).and_return(plaintiff)

      post :create

      response.should redirect_to new_ticket_path
    end
  end

  describe "#index" do
    it "redirects to the root path " do
      get :index
      response.should redirect_to root_path
    end
  end
end
