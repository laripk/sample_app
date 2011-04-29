require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = { 
      :name => "Example User", 
      :email => "user@example.com",
      :password => "foobar",
      :password_confirmation => "foobar"
    }
  end
  
  
  describe "micropost associations" do
    
    before(:each) do
      @user = User.create!(@attr)
      @u1mp1 = Factory(:micropost, :user => @user, :created_at => 1.day.ago)
      @u1mp2 = Factory(:micropost, :user => @user, :created_at => 1.hour.ago)
      u2 = User.create!(@attr.merge(:email => "user2@example.com"))
      @u2mp3 = Factory(:micropost, :user => u2)
    end
    
    it "should have a microposts attribute" do
      @user.should respond_to(:microposts)
    end
    
    it "should have the right microposts in the right order" do
      @user.microposts.should == [@u1mp2, @u1mp1]
      @user.microposts.include?(@u2mp3).should be_false # I just felt the need to emphasise this
    end
    
    it "should destroy associated microposts" do
      @user.destroy
      [@u1mp1, @u1mp2].each do |micropost|
        Micropost.find_by_id(micropost.id).should be_nil
        # another way to test it, for reference
        # lambda do
        #   Micropost.find(micropost.id)
        # end.should raise_error(ActiveRecord::RecordNotFound)
      end
    end
    
    describe "status feed" do
      
      it "should have a feed" do
        @user.should respond_to(:feed)
      end
      
      it "should include the user's microposts" do
        @user.feed.include?(@u1mp1).should be_true
        @user.feed.include?(@u1mp2).should be_true
      end
      
      it "should not include a different user's microposts" do
        @user.feed.include?(@u2mp3).should be_false
      end
      
    end #feed
    
  end #microposts assoc

end