require 'rails_helper'

describe DriversController do
	 before :each do
        @params = {"user_id" => "1"}
        @fake_user = FactoryGirl.create(:user, "name" => "John Smith", "email" => "jsmith@colgate.edu", "birthday" => "1990-01-04")
        @fake_driver = FactoryGirl.create(:driver, "id" => "1", "user_id" => "1")
    end
    
    describe "POST #create" do
        it "routes to drivers#create" do
            post :create, :user_id => @fake_user.id
            expect(response.status).to eq(200)
        end
    end

    describe "POST #destroy" do
        it "routes to drivers#destroy" do
            delete :destroy, :user_id => @fake_user.id, :id => @fake_driver.id
            expect(response.status).to eq(200)
        end
    end

    describe "get #first" do
        it "routes to drivers#first" do
            get :first, :user_id => @fake_user.id, :driver_id => @fake_driver.id
            expect(response.status).to eq(200)
        end
    end

    describe "get #num" do
        it "routes to drivers#num" do
            get :num, :user_id => @fake_user.id, :driver_id => @fake_driver.id
            expect(response.status).to eq(200)
        end
    end

    describe "adding a user to the drive list" do
        it "should call the User find model method and the DriveList new model method" do
           User.should_receive(:find).with(@params["user_id"]).and_return(@fake_user)
           Driver.should_receive(:new).with({"id"=> "1"}).and_return(@fake_driver)
           post :create, @params
           flash[:notice].should == "You are now waiting for a rider"
           response.should redirect_to(wait_driver_path(@fake_driver))
        end
    end

    describe "deleting a user from the drive list"
     
    describe "getting the first user from the drive list"
    
    describe "getting the number of users waiting on the drive list"
end
