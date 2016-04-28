class TweetsController < ApplicationController
  def new

  end
  def create
    consumer_key = OAuth::Consumer.new(
        Rails.application.secrets.consumer_key,
        Rails.application.secrets.consumer_secret
        )
    access_token = OAuth::Token.new(
        Rails.application.secrets.access_token,
        Rails.application.secrets.access_token_secret
       )

    baseurl = "https://api.twitter.com"
    path    = "/1.1/statuses/update.json"
    address = URI("#{baseurl}#{path}")
    request = Net::HTTP::Post.new address.request_uri
    request.set_form_data(
        "status" => twitter_params[:message],
    )

# Set up HTTP.
    http             = Net::HTTP.new address.host, address.port
    http.use_ssl     = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

# Issue the request.
    request.oauth! http, consumer_key, access_token
    http.start
    response = http.request request

# Parse and print the Tweet if the response code was 200
    tweet = nil
    if response.code == '200' then
      tweet = JSON.parse(response.body)
      flash[:success] = " Status - #{response.code}" + " <br/> Successfully sent: #{tweet["text"]}"
      redirect_to root_path
    else
      flash[:warning] = "Could not send the Tweet! " +
               "Code:#{response.code} <br/> Body:#{response.body}"
      redirect_to root_path
    end
  end

  private

  def twitter_params
    params.require(:tweet).permit(:message)
  end
end
