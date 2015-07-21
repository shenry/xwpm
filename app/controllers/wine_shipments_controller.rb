class WineShipmentsController < ApplicationController  
  def new
    wine = Wine.find(params[:wine_id])
    today = Date.today.strftime("%m/%d/%y")
    @wine_shipment = wine.wine_shipments.new(customer_id: params[:c_id], ship_date: today)
  end
  
  def create
    @wine_shipment = WineShipment.new(wine_shipment_params)
    ship_date = params[:wine_shipment][:ship_date]
    @wine_shipment.ship_date = Date.strptime(ship_date, "%m/%d/%y")
    if @wine_shipment.save
      redirect_to wine_path(@wine_shipment.wine)
    else
      render action: :new
    end
  end
  
  def update
    @wine_shipment = WineShipment.find(params[:id])
    respond_to do |wants|
      if @wine_shipment.update_attributes(wine_shipment_params)
        puts "updated wine shipment!!"
        wants.json { respond_with_bip @wine_shipment }
      end
    end
  end
  
  private
  def wine_shipment_params
    params.require(:wine_shipment).permit(:ship_date, :tracking_number, :wine_id, :customer_id, :accepted, :feedback)
  end
end