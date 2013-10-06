class SessionsController < ApplicationController
  before_filter :get_session_params, :only => [ :create ]

  def new
  end

  def create
    plaintiff = Plaintiff.where(:conditions => @session_params).first

    unless plaintiff
      flash[:error] = "We couldn't find a plaintiff record matching the information you provided."
      return redirect_to new_session_path
    end

    session[:plaintiff] = plaintiff

    return redirect_to new_ticket_path
  end

  protected

  def get_session_params
    @session_params = [ :email, :postal_code ].reduce({}) do |hash, key|
      hash[key] = params[:session][key]
      hash
    end
  end
end
