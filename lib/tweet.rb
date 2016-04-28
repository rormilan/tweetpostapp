require 'rubygems'
require 'oauth'
require 'json'
module Tweet
    def status_update(text)
      set_up_request(text)
      set_up_http
      set_up_credentials
      @request.oauth! @http, @consumer_key, @access_token
      @http.start
      @http.request @request
    end
    private
    def set_up_credentials
      @consumer_key = OAuth::Consumer.new(
          Rails.application.secrets.consumer_key,
          Rails.application.secrets.consumer_secret
      )
      @access_token = OAuth::Token.new(
          Rails.application.secrets.access_token,
          Rails.application.secrets.access_token_secret
      )
    end
    def set_up_request(text)
      baseurl = "https://api.twitter.com"
      path    = "/1.1/statuses/update.json"
      @address = URI("#{baseurl}#{path}")
      @request = Net::HTTP::Post.new @address.request_uri
      @request.set_form_data(
          "status" => text,
      )
    end
    def set_up_http
      @http             = Net::HTTP.new @address.host, @address.port
      @http.use_ssl     = true
      @http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    end

end