class PeopleController < ApplicationController
  before_action :fetch_person, only: [:show, :edit, :update, :destroy]
  
  def index
    @people = Person.all
    
    respond_to do |format|
      format.html
      format.json { render json: @people }
    end
  end

  def show

  end
  
  def new
    @person = Person.new
  end
  
  def create
    @person = Person.new(params[:person])
    if @person.save
      flash[:notice] = "Successfully created a new person."
      flash[:color]  = "valid"
    else
      flash[:notice] = "Something doesn't look right..."
      flash[:color]  = "invalid"
    end
    render "new"
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    
  end
  
  private
  def fetch_person
    @person = Person.find(params[:id])
  end    
end
