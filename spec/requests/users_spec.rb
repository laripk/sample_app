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
        integration_sign_in(Factory(:user), "invalid")
        flash[:error].should_not be_empty
      end
      
    end #failure
    
    describe "success" do
      
      it "should have no errors" do
        integration_sign_in(Factory(:user))
        flash[:error].should be_nil
      end
      
    end #success
    
  end #sign in
  
  describe "sign in/out" do
    
    describe "failure" do
      
      it "should not sign a user in" do
        visit signin_path
        fill_in :email,    :with => ""
        fill_in :password, :with => ""
        click_button
        response.should have_selector("div.flash.error", :content => "Invalid")
      end
      
    end #failure
    
    describe "success" do
      
      it "should sign a user in and out" do
        integration_sign_in(Factory(:user))
        controller.should be_signed_in
        click_link "Sign out"
        controller.should_not be_signed_in
      end
      
    end #success
    
  end #sign in/out
  
  describe "Factory_visit_problem" do
    
    describe "Factory then visit signin" do
      it "should create a user" do
        # print "\nFac signin"
        lambda do
          user = Factory(:user)
          visit signin_path
        end.should change(User, :count).by(1)
      end
    end #Factory signin
    
    describe "visit signin then Factory" do
      it "should create a user" do
        # print "\nsignin Fac"
        lambda do
          visit signin_path
          user = Factory(:user)
        end.should change(User, :count).by(1)
      end
    end #signin Factory
    
    describe "Factory then visit root" do
      it "should create a user" do
        # print "\nFac root"
        lambda do
          user = Factory(:user)
          visit root_path
        end.should change(User, :count).by(1)
      end
    end #Factory root
    
    describe "Factory then visit signup" do
      it "should create a user" do
        # print "\nFac signup"
        lambda do
          user = Factory(:user)
          visit signup_path
        end.should change(User, :count).by(1)
      end
    end #Factory signup
    
    describe "Factory then visit signout" do
      it "should create a user" do
        # print "\nFac signout"
        lambda do
          user = Factory(:user)
          # debugger
          visit signout_path
        end.should change(User, :count).by(1)
      end
    end #Factory signout
    
    describe "Factory then visit contact" do
      it "should create a user" do
        # print "\nFac contact"
        lambda do
          user = Factory(:user)
          visit contact_path
        end.should change(User, :count).by(1)
      end
    end #Factory contact
    
    describe "Factory then visit about" do
      it "should create a user" do
        # print "\nFac about"
        lambda do
          user = Factory(:user)
          visit about_path
        end.should change(User, :count).by(1)
      end
    end #Factory about
    
    describe "Factory then visit help" do
      it "should create a user" do
        # print "\nFac help"
        lambda do
          user = Factory(:user)
          visit help_path
        end.should change(User, :count).by(1)
      end
    end #Factory help
    
  end #factory visit
  
  describe "users list" do
    
    describe "admins" do
      it "should see delete links" do
        admin = Factory(:user, :email => "admin@example.com", :admin => true)
        integration_sign_in(admin)
        visit users_path
        response.should have_selector("a", :content => "delete")
      end
    end #admins
    
    describe "non-admins" do
      it "should not see delete links" do
        user = Factory(:user)
        integration_sign_in(user)
        visit users_path
        response.should_not have_selector("a", :content => "delete")
      end
    end #non-admins
    
  end #users list
  
end
