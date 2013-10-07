class PlaintiffsController < ApplicationController
  def new
    @plaintiff = @plaintiff || Plaintiff.new
  end

  def create
    @plaintiff = Plaintiff.create(plaintiff_params)

    unless @plaintiff and @plaintiff.errors.empty?
      return render :new
    end

    session[:plaintiff] = @plaintiff

    return redirect_to new_ticket_path
  end

  def index
    return redirect_to :root_path
  end

  protected

  def plaintiff_params
    params.require(:plaintiff).permit(:fullname, :street_address1, :street_address2, :postal_code, :email, :phone, :is_public, :country)
  end
end
