class BottlesController < ApplicationController
  def index
    @status   = params[:status] || "active"
    @bottles  = Bottle.send(@status.intern)
  end
  
  def show
    
  end
end