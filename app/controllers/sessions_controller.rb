class SessionsController < ApplicationController
  def new

  end

  def create
    n, pw = params[:session][:name], params[:session][:password]
    current_user = Person.ci_search!(n).authenticate!(pw)
    sign_in current_user
    redirect_to root_path
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Sorry, I don't know that person."
    redirect_to root_path
  rescue ActiveRecord::AuthenticationError
    flash[:error] = "That's not the right password."
    redirect_to root_path
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end