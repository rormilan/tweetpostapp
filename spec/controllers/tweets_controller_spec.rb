require 'rails_helper'

describe TweetsController do
  describe "GET new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end
  describe "POST tweet" do
      include Tweet
      context "when valid" do
        it "should give success message in flash" do
          post :create, tweet:{:message => "Khadichaur hudai jane"}
          expect(flash[:success]).to have_content(/^Code: 200/)
        end
      end
      context "when invalid" do
        it "should give error message in flash" do
          post :create, tweet:{:message => ""}
          expect(flash[:warning]).to have_content(/^Code: 403/)
        end
      end
  end
end