require 'rails_helper'

describe 'the view page' do

  it "should have the content 'Message'" do
    visit '/tweets/new'
    expect(page).to have_content 'Message'
  end
  it "should have the submit button" do
    visit '/tweets/new'
    expect(page).to have_selector('input[type=submit]')
  end
  it "should have the text area" do
    visit '/tweets/new'
    expect(page).to have_selector("textarea", :text => '')
  end
  scenario "should give error message with invalid data" do
    visit '/tweets/new'
    within 'form' do
      find('#Submit').click
    end
    expect(page).to have_content "Code: 403"
  end
  scenario "should give success message with valid data" do
    visit '/tweets/new'
    within 'form' do
      find('#textarea').set('I am testing from Rspec again and again and again')
      find('#Submit').click
    end
    expect(page).to have_content "Code: 200"
  end
end