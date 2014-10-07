class SessionsController < ApplicationController
  def new

  end

  def create
    n, pw = params[:session][:name], params[:session][:password]
    current_user = Person.ci_search!(n).authenticate!(pw)
    
    # do stuff with current_user, redirect_to root_path, etc.

  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Sorry, I don't know that person."
    render "pages/home"
  rescue ActiveRecord::AuthenticationError
    flash[:error] = "That's not the right password."
    render "pages/home"
  end

  def destroy

  end
end