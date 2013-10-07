class TicketsController < ApplicationController
  before_filter :plaintiff_required, :only => [ :new, :create ]

  def new
    @ticket = @ticket || Ticket.new
  end

  def create
    @ticket = @plaintiff.tickets.create(ticket_params)

    unless @ticket and @ticket.errors.empty?
      return render :new
    end

    flash[:notice] = "Your ticket has been recorded. Thanks! You can enter another if you are unfortunate to have been ticketed multiple times."

    return redirect_to new_ticket_path
  end

  def index
    return redirect_to root_path
  end

  protected

  def ticket_params
    params.require(:ticket).permit(:number, :fine_cents, :expenses_cents, :location, :date, :officer_id, :hearing_date, :hearing_verdict, :appeal_date, :appeal_verdict, :description)
  end

  def plaintiff_required
    @plaintiff = session[:plaintiff]

    unless @plaintiff
      flash[:error] = "Please first log in or register as a new plaintiff."
      return redirect_to new_plaintiff_path
    end
  end
end
