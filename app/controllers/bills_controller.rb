class BillsController < ApplicationController
  before_action :authorize, only: [:edit, :update]

  def index
    @bills = Bill.where("owed > 0")

    respond_to do |format|
      format.html
      format.json { render json: @bills }
    end
  end

  def show
    @bill = Bill.find(params[:id])
  end

  def new
    @bill = Bill.new
  end

  def edit

  end

  def update
    if @bill.update(bill_params)
      flash[:notice] = "Changes saved."
    else
      flash[:error] = "Something doesn't look right..."
    end
    render "edit"
  end

  def destroy

  end

  private

  def bill_params
    params.require(:bill).permit(:owed, :late)
  end

  def authorize
    @bill = Bill.find(params[:id])
    case
    when !signed_in?
      redirect_to root_path,
        flash: {error: "You have to be signed in to do that."}
    when !current_user.admin?
      redirect_to root_path,
        flash: {error: "Hey, you're not allowed to do that!"}
    end
  end
end
