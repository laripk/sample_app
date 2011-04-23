require 'spec_helper'

describe "Users" do
  
  describe "signup" do
    
    describe "failure" do
      
      it "should not make a new user" do
        lambda do
          visit signup_path
          fill_in "Name",         :with => ""
          fill_in "Email",        :with => ""
          fill_in "Password",     :with => ""
          fill_in "Confirmation", :with => ""
          click_button
          response.should render_template('users/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(User, :count)
      end
      
    end #failure
    
    describe "success" do
      
      it "should make a new user" do
        lambda do
          visit signup_path
          fill_in "Name",         :with => "Example User"
          fill_in "Email",        :with => "integrate@example.com"
          fill_in "Password",     :with => "foobar"
          fill_in "Confirmation", :with => "foobar"
          click_button
          response.should have_selector("div.flash.success", 
                                        :content => "Welcome")
          response.should render_template('users/show')
        end.should change(User, :count).by(1)
      end
      
    end #success
    
  end #sign up
  
  describe "sign in" do
    
    describe "failure" do
      
      it "should have errors" do 
        @user = Factory(:user)
        visit signin_path
        fill_in :email,    :with => @user.email
        fill_in :password, :with => "invalid"
        click_button
        flash[:error].should_not be_empty
      end
      
    end #failure
    
    describe "success" do
      
      it "should have no errors" do
        print User.count
        @user = Factory(:user)
        print "user in db=", !User.find_by_email(@user.email).nil?
        print User.count
        visit signin_path
        print "user in db=", !User.find_by_email(@user.email).nil?
        print User.count
        @user = Factory(:user)
        print "user in db=", !User.find_by_email(@user.email).nil?
        print User.count
        fill_in :email,    :with => @user.email
        fill_in :password, :with => @user.password
        click_button
        print controller.params.inspect
        print flash.inspect
        flash[:error].should be_nil
      end
      
    end #success
    
  end #sign in
  
end
