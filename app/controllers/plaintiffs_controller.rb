class PlaintiffsController < ApplicationController
  def new
    @plaintiff = Plaintiff.new
  end
end
