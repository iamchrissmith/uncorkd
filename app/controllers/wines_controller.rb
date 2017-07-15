class WinesController < ApplicationController

  before_action :set_wine, only: [:show]

  def index
    @wines = Wine.paginate(:page => params[:page], :per_page => 30)
  end

  def show
  end

  private
    def set_wine
      @wine = Wine.find(params[:id])
    end
end
