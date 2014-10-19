class PeopleController < ApplicationController
  before_action :fetch_person, only: [:show, :destroy]
  before_action :authorize, only: [:edit, :update]

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
    
  end
  
  def update
    if @person.update(current_user.admin? ? person_params_admin : person_params)
      flash[:notice] = "Settings updated."
    else
      flash[:error] = "Something doesn't look right..."
    end
    render "edit"
  end
  
  def destroy
    
  end
  
  private

  def fetch_person
    @person = Person.find(params[:id])
  end
  
  def person_params
    params.require(:person).permit(:name, :email, :password, :password_confirmation,
                                   :email_me)
  end

  def person_params_admin
    params.require(:person).permit(:name, :email, :password, :password_confirmation,
                                   :owes, :admin, :email_me)
  end

  def authorize
    @person = Person.find(params[:id])
    case
    when !signed_in?
      redirect_to root_path, 
        flash: {error: "You have to be signed in to do that."}      
    when !(current_user == @person || current_user.admin?)
      redirect_to root_path, 
        flash: {error: "Hey, you're not allowed to do that!"}
    end
  end
end