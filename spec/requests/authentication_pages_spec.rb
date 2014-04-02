require 'spec_helper'

describe "AuthenticationPages" do
  subject { page }

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign In" }

      it { should have_title('Sign In') }
      it { should have_selector('div.alert.alert-danger') }

      describe "after visiting another page" do
        before { click_link "Blog" }
        it { should_not have_selector('div.alert.alert-danger') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",    with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Sign In"
      end

      it { should have_title(user.name) }
      it { should have_link('Sign Out') }
      it { should_not have_link('Sign in') }

      describe "followed by signout" do
        before { click_link "Sign Out" }

        it { should_not have_link('Sign Out') }
        it { should have_link('Sign In') }
      end

    end
  end
end
