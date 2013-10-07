class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def home
    @tickets      = Ticket.joins(:plaintiff).where("plaintiffs.is_public" => true).limit(20).order("created_at DESC").map{|ticket| ticket.to_hash}
    @ticket_count = Ticket.count

    render './home'
  end
end
