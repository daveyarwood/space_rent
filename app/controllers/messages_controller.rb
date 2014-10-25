class MessagesController < ApplicationController
  before_action :authorize, only: [:index]

  def index
    @messages = Message.all

    respond_to do |format|
      format.html
      format.json { render json: @messages }
    end
  end

  def create
    @message = current_user.messages.create(message_params)
    redirect_to root_path
  end

  private

  def message_params
    params[:message][:person] = current_user if signed_in?
    params.require(:message).permit(:person, :text)
  end

  def authorize
    if !signed_in?
      redirect_to root_path,
        flash: {error: "You have to be signed in to do that."}
    end
  end
end
