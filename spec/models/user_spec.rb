require 'spec_helper'

describe User do
  #pending "add some examples to (or delete) #{__FILE__}" #default from generate
  before(:each) do
    @attr = { :name=> "Example User", :email => "user@example.com" }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    #no_name_user.valid?.shoud_not == true  # same as line below
    no_name_user.should_not be_valid
  end

  it "should require a email address" do
    no_email_user = User.new(@attr.merge(:email => ""))
    #no_name_user.valid?.shoud_not == true  # same as line below
    no_email_user.should_not be_valid
  end

  it "should reject names that are too long" do
    long_name = "a" *51
    long_name_usr = User.new(@attr.merge(:name => long_name))
    long_name_usr.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate email addresses ignoring case" do
    # put a user in DB 
    User.create!(@attr)

    #try and create same user with upcase email
    upcase_email=@attr[:email].upcase #extract email from attr and upcase it
    user_with_duplicate_email = User.new(@attr.merge(:email => upcase_email))
    user_with_duplicate_email.should_not be_valid
  end
end

# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

