class SessionsController < ApplicationController
  before_filter :get_session_params, :only => [ :create ]

  def new
    @plaintiff = Plaintiff.new
  end

  def create
    @plaintiff = Plaintiff.for_email_and_postal_code(@session_params[:email], @session_params[:postal_code])

    unless @plaintiff
      # just for populating the form again
      @plaintiff = Plaintiff.new(@session_params)

      flash[:error] = "We couldn't find a plaintiff record matching the information you provided."
      return render :new
    end

    session[:plaintiff] = @plaintiff

    flash[:notice] = "You've been logged in. You can submit a ticket now."
    return redirect_to new_ticket_path
  end

  protected

  def get_session_params
    unless params[:plaintiff]
      flash[:error] = "Plaintiff information was not provided"
      return render :new
    end

    @session_params = {
      :email       => params[:plaintiff][:email],
      :postal_code => params[:plaintiff][:postal_code]
    }
  end
end
