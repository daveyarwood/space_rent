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
    @person = Person.new(person_params)
    if @person.save
      flash[:notice] = "Successfully created a new person."
    else
      flash[:error] = "Something doesn't look right..."
    end
    render "new"
  end
  
  def edit
    @person = Person.find(params[:id])
  end
  
  def update
    
  end
  
  def destroy
    
  end
  
  private
  def fetch_person
    @person = Person.find(params[:id])
  end
  
  def person_params
    params.require(:person).permit(:name, :email, :password, :password_confirmation)
  end
end