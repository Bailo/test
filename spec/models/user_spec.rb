require 'spec_helper'

describe User do
  before { @user = User.new(name: 'Example User', email: 'test@example.com', password: 'foobar', password_confirmation: 'foobar' ) }

  subject { @user }

  it { should respond_to(:name)  }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }

  it { should be_valid }

  describe "when username is not present" do
  	before { @user.name = " " }
  	it { should_not be_valid }
  end

  describe "when name more then 50 symbols" do
  	before { @user.name = "a" * 51 }
  	it { should_not be_valid }
  end

  describe "when email is not present" do
  	before { @user.email = " " }
  	it { should_not be_valid }
  end

  describe "when email format is invalid" do
  	it "should be invalid" do
  		addresses = %w[user@foo,com user_at_foo.org exaple.user@foo. test@foo+bar.com]
  		addresses.each do |invalid_address| 
  			@user.email = invalid_address
  			expect(@user).not_to be_valid
  		end
  	end	
  end	

  describe "when email format is valid" do
  	it "should be valid" do
  		addresses = %w[user@foo.com VCP_DFD-dfd@mdf.com fr.ls@ld.jp a+b@cfd.cn]
  		addresses.each do |valid_address|
  			@user.email = valid_address
  			expect(@user).to be_valid
  		end
  	end
  end	

  describe "when email address is already taken" do
		before do 
			user_with_same_email = @user.dup
			user_with_same_email.email = @user.email.upcase
			user_with_same_email.save
		end

		it { should_not be_valid }
	end

	describe "when password is not present" do
		before { @user.password = @user.password_confirmation = " " }
		it { should_not be_valid }
	end

	describe "when password doesn't match confirmation" do
		before { @user.password_confirmation = "mismatch" }
		it { should_not be_valid }
	end

	describe "password must be less than 6 symbols" do
		before { @user.password = @user.password_confirmation = "a" * 5 }
		it { should be_invalid }
	end

	describe "return value of authenticate method" do
		before { @user.save }
		let(:found_user) { User.find_by(email: @user.email)	}

		describe "with valid password" do
			it { should eq found_user.authenticate(@user.password) }
		end

		describe "with invalid password" do
			let(:user_for_invalid_password) { found_user.authenticate("invalid") }
			it { should_not eq user_for_invalid_password }
			specify { expect(user_for_invalid_password).to be_false }
		end
	end
end