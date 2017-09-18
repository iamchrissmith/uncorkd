require 'will_paginate/array'
class WinesController < ApplicationController
  def index
    if params[:search].present?
      @wines = Wine.text_search(params[:search]).paginate(:page => params[:page], :per_page => 30)
    else
      @wines = SnoothWine.return_all.paginate(:page => params[:page], :per_page => 30)
    end
  end

  def show
    @wine_data = WineShowPresenter.new(params[:id])
  end
end
