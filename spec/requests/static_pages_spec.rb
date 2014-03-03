require 'spec_helper'

describe "StaticPages" do

  describe "Home page" do
    it "works and have the title 'Home'" do
      visit '/static_pages/home'
      expect(page).to have_content()
      expect(page).to have_title("Home")
    end
  end

  describe "About page" do
    it "works" do
      visit '/static_pages/about'
      expect(page).to have_content()
      expect(page).to have_title("About")
    end
  end
end

