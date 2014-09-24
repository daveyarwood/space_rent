class TabsController < ApplicationController
  def index
    @tabs = Tab.all
    
    respond_to do |format|
      format.html
      format.json { render json: @tabs }
    end
  end

  def show
    @tab = Tab.find(params[:id])
  end
end
