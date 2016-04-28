class TweetsController < ApplicationController
  def new

  end
  def create
    update_status(twitter_params[:message])
    flash[:success] = @response
    redirect_to root_path
  end
  private
  def twitter_params
    params.require(:tweet).permit(:message)
  end
end
