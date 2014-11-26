class PeopleController < ApplicationController
  before_action :fetch_person, only: [:edit, :show, :update, :destroy]
  before_action :authorize, only: [:new, :edit, :update, :destroy]

  def index
    @people = Person.all
    
    respond_to do |format|
      format.html
      format.json { render json: @people }
    end
  end
  
  def new
    @person = Person.new
  end
  
  def create
    @person = Person.new(current_user.admin? ? person_params_admin : person_params)
    if @person.save
      UserMailer.welcome(@person).deliver
      flash[:notice] = "Successfully created a new person."
      redirect_to new_person_path
    else
      flash[:error] = "Something doesn't look right..."
      render "new"
    end
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
    @person.destroy
    redirect_to root_path, notice: "No more #{@person.name}."
  end
  
  private
  
  def person_params
    params.require(:person).permit(:name, :email, :password, :password_confirmation,
                                   :email_me)
  end

  def person_params_admin
    params.require(:person).permit(:name, :email, :password, :password_confirmation,
                                   :owes, :admin, :email_me)
  end
  
  def fetch_person
    @person = Person.find(params[:id])
  end

  def authorize
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