class PlaintiffsController < ApplicationController
  before_filter :get_plaintiff_params, :only => [ :create ]

  def new
    @plaintiff = @plaintiff || Plaintiff.new
  end

  def create
    @plaintiff = Plaintiff.create(@plaintiff_params)

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

  def get_plaintiff_params
    unless params[:plaintiff]
      flash[:error] = "Plaintiff information was not provided"
      return render :new
    end

    @plaintiff_params = [
      :fullname,
      :street_address1,
      :street_address2,
      :postal_code,
      :email,
      :phone,
      :is_public,
      :country_code
    ].reduce({}) do |hash, key|
      hash[key] = params[:plaintiff][key]
      hash
    end
  end
end
