require 'spec_helper'

describe "UserPages" do
  subject { page }

  describe "signup page" do 
  	before { visit signup_path }

  	it { should have_content() }
  	it { should have_title('Sign Up') }
  end
end