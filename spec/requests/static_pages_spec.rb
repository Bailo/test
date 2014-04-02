require 'spec_helper'

describe "StaticPages" do

  subject { page }
	
  describe "Home page" do
    before { visit root_path }
    it { should_not have_title('Home')}
  end

  describe "Blog page" do
    before { visit blog_path }
    it { should have_title('Blog') }
  end

  describe "Contact page" do
    before { visit contact_path }
    it { should have_title('Contacts') }
  end

  describe "Champ page" do
    before { visit champ_path }
    it { should have_title('Championship') }
  end

  describe "Gallery page" do
    before { visit gallery_path }
    it { should have_title('Gallery') }
  end

  describe "Participants page" do
    before { visit participants_path }
    it { should have_title('Participants') }
  end


end

