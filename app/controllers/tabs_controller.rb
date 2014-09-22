class TabsController < ApplicationController
  def index
    @tabs = Tab.all
  end

  def show
    @tab = Tab.find(params[:id])
  end
end
