class BillsController < ApplicationController
  before_action :fetch_bill, only: [:show, :edit, :update, :destroy]

  def index
    @bills = Bill.where("owed > 0")
    
    respond_to do |format|
      format.html
      format.json { render json: @bills }
    end
  end

  def show
    
  end
  
  def new
    
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    
  end
  
  private
  def fetch_bill
    @bill = Bill.find(params[:id])
  end    
end
