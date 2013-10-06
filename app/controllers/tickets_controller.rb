class TicketsController < ApplicationController
  before_filter :get_ticket_params,  :only => [ :create ]
  before_filter :plaintiff_required, :only => [ :check_plaintiff ]

  def new
    @ticket = @ticket || Ticket.new
  end

  def create
    @ticket = Ticket.create(@ticket_params)

    unless @ticket and @ticket.errors.empty?
      return render :new
    end

    flash[:info] = "Your ticket has been recorded. Thanks! You can enter another if you are unfortunate to have been ticketed multiple times."

    return redirect_to new_ticket_path
  end

  def index
    return redirect_to root_path
  end

  protected

  def get_ticket_params
    @ticket_params = [
      :number,
      :fine,
      :expenses,
      :location,
      :date,
      :officer_id,
      :hearing_date,
      :hearing_verdict,
      :appeal_date,
      :appeal_verdict,
      :description,
      :plaintiff_id
    ].reduce({}) do |hash, key|
      hash[key] = params[:ticket][key]
      hash
    end
  end

  def check_plaintiff
    unless session[:plaintiff]
      flash[:error] = "Please first log in or register as a new plaintiff."
      return redirect_to new_plaintiff_path
    end
  end
end
