require 'rails_helper'

describe User do
    describe "signing in via google" do
        context "user account exists in app db" do
            it 'should redirect to google authentication and return a user' do
                fake_user = FactoryGirl.build(:user, :name => "John Smith", :email => "jsmith@colgate.edu", :birthday => "1/2/1991")
                fake_user.save
                fake_access_token = double("AccessToken")
                fake_access_token.stub(:info).and_return("name" => "John Smith", "email" => "jsmith@colgate.edu")
                User.find_for_google_oauth2(fake_access_token, nil).should == fake_user
            end
        end
        context "user account does not exist in app db" do
            it "should redirect to google auth, create a new user, and return the new user" do
                fake_access_token = double("AccessToken")
                fake_access_token.stub(:info).and_return("name" => "John Smith", "email" => "jsmith@colgate.edu")
                new_user = User.find_for_google_oauth2(fake_access_token, nil)
                new_user.name.should == "John Smith"
                new_user.email.should == "jsmith@colgate.edu"
            end
        end
    end

end
