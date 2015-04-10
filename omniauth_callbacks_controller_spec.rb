require 'spec_helper'

describe OmniauthCallbacksController do
    describe 'signing in' do
        before :each do
            @fake_user_existing = FactoryGirl.build(:user, :name => "Young John", :email => "yjohn@colgate.edu", :password => "johnspassword")
            @fake_user_new = FactoryGirl.build(:user, :name => "Old Joe", :email => "ojoe@colgate.edu", :password => "joespassword")
        end
        it 'should call the model method that performs the Google sign in' do
            User.should_receive(:find_for_google_oauth2).with('d396f16a8890264c3e44ca4bda653919950d436afa8ebd2d',"4/6HCtIhxx52JrHmWnXVNJLOMHiLHedP5jo_MniZztKRc.4isuUOvp7NkRgtL038sCVnsbQSg2mQI").and_return(fake_user)
            post :google_oauth, {:state => 'd396f16a8890264c3e44ca4bda653919950d436afa8ebd2d', :code => "4/6HCtIhxx52JrHmWnXVNJLOMHiLHedP5jo_MniZztKRc.4isuUOvp7NkRgtL038sCVnsbQSg2mQI"}         
        end
        context 'user account exists' do
            it 'should select welcome page for rendering' do
                User.stub(:find_google_oauth2).and_return(@fake_user_existing)
                post :google_oauth, {:state => 'd396f16a8890264c3e44ca4bda653919950d436afa8ebd2d', :code => "4/6HCtIhxx52JrHmWnXVNJLOMHiLHedP5jo_MniZztKRc.4isuUOvp7NkRgtL038sCVnsbQSg2mQI"}         
                response.should render_template('users/welcome')
            end
            it 'should make the user available to the welcome template'
                assigns(:user).should == @fake_user_existing
        end
        context 'user account does not exist' do
            it 'should select the register page for rendering'
                User.stub(:find_google_oauth2).and_return(@fake_user_new)
                post :google_oauth, {:state => 'd396f16a8890264c3e44ca4bda653919950d436afa8ebd2d', :code => "4/6HCtIhxx52JrHmWnXVNJLOMHiLHedP5jo_MniZztKRc.4isuUOvp7NkRgtL038sCVnsbQSg2mQI"}         
                response.should render_template('users/register')
            it 'should make the user available to the register template'
                assigns(:user).should == @fake_user_new
        end
    end
end

