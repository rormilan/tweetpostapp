class TweetsController < ApplicationController
  include Tweet
  def new

  end
  def create
  response = status_update(twitter_params[:message])
  # Parse and print the Tweet if the response code was 200
    tweet = nil
    if response.code == '200' then
      tweet = JSON.parse(response.body)
      flash[:success] = " Code: #{response.code}" + " <br/> Successfully sent: #{tweet["text"]}"
      redirect_to root_path
    else
      flash[:warning] = "Code: #{response.code} " + " <br/>Could not send the Tweet!,  Body:#{response.body}"
      redirect_to root_path
    end
  end

  private

  def twitter_params
    params.require(:tweet).permit(:message)
  end
end
