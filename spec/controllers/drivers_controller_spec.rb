require 'rails_helper'

describe DriversController do
    context "check routes" do 
        before :each do
            @params = {"user_id" => "1"}
            @fake_user = FactoryGirl.create(:user, "name" => "John Smith", "email" => "jsmith@colgate.edu", "birthday" => "1990-01-04")
            @fake_driver = FactoryGirl.create(:driver, "id" => "1", "user_id" => "1")
        end
        describe "POST #create" do
            it "routes to drivers#create" do
                post :create, :user_id => @fake_user.id
                expect(response.status).to eq(302)
            end
        end

        describe "DELETE #destroy" do
            it "routes to drivers#destroy" do
                delete :destroy, :user_id => @fake_user.id, :id => @fake_driver.id
                expect(response.status).to eq(302)
            end
        end

    end
    describe "adding a user to the drive list" do
        before :each do
           @params = {"user_id" => "1"}
           @fake_user = FactoryGirl.create(:user, "name" => "John Smith", "email" => "jsmith@colgate.edu", "birthday" => "1990-01-04")
           @fake_driver = FactoryGirl.create(:driver, "id" => "1", "user_id" => "1")
           User.should_receive(:find).with(@params["user_id"]).and_return(@fake_user)
           Driver.should_receive(:new).and_return(@fake_driver)
        end
        it "should redirect to wait on success" do
           @fake_driver.should_receive(:save).and_return(true)
           post :create, @params
           flash[:notice].should == "You are now waiting for a rider."
           assigns(:user).driver.should == @fake_driver
           response.should redirect_to(user_driver_wait_path(@fake_user, @fake_driver))
        end

        it "should redirect to the user welcome page on failure" do
           @fake_driver.should receive(:save).and_return(nil)
           post :create, @params
           flash[:notice].should == "Failed to add you as an available driver.  Please try again"
           response.should redirect_to(welcome_user_path(@fake_user))
        end
    end

    describe "deleting a user from the drive list" do
        before :each do
            @params = {"id" => "1"}
            @fake_user = FactoryGirl.create(:user, "name" => "John Smith", "email" => "jsmith@colgate.edu", "birthday" => "1990-01-04", "driver" => @fake_driver)
            @fake_driver = FactoryGirl.create(:driver, "id" => "1", "user_id" => "1")
            Driver.should_receive(:find).with(@params["id"]).and_return(@fake_driver)
            @fake_driver.should_receive(:destroy)
            delete :destroy, :user_id => @fake_user, :id => @fake_driver
        end
        it "should redirect to the user welcome page" do
            response.should redirect_to(welcome_user_path(:id => @fake_user))
        end
        it "should display the success message" do
            flash[:notice].should == "Driver inactive"
        end
        it "should not be associated with the user" do
            @fake_user.driver.should == nil
        end

    end
    
    describe "test private controller methods" do
        before :each do
        
            @fake_user1 = FactoryGirl.create(:user, "name" => "John Smith", "email" => "jsmith@colgate.edu", "birthday" => "1990-01-04", "driver" => @fake_driver1)
            @fake_user2 = FactoryGirl.create(:user, "name" => "Joe Buck", "email" => "jbuck@colgate.edu", "birthday" => "1990-02-04", "driver" => @fake_driver2)
            @fake_driver1 = FactoryGirl.create(:driver, "id" => "1", "user_id" => "1")
            @fake_driver2 = FactoryGirl.create(:driver, "id" => "2", "user_id" => "2")
            @controller = DriversController.new
        end

        describe "getting the first user from the driver list" do
            before :each do
                Driver.should_receive(:first).and_return(@fake_driver1)
                User.should_receive(:find).with(@fake_driver1.user_id).and_return(@fake_user1)
            end
            it "should return the first user from the driver list" do
                @controller.send(:first).should == @fake_user1
            end
            it "should return the first user waiting on the list after users are deleted from the list" do
                @controller.send(:first).should == @fake_user1
                delete :destroy, :user_id => @fake_user1, :id => @fake_driver1
                @controller.send(:first).should == @fake_user2
            end
        end
    
        describe "getting the number of users waiting on the drive list" do
            before :each do
                Driver.should_receive(:count).and_return(2)
            end
            it "should return the number of users waiting on the list" do
                @controller.send(:num).should == 2
            end
            it "should return the number of users waiting on the list after users are deleted from the list" do
                @controller.send(:num).should == 2
                delete :destroy, :user_id => @fake_user1, :id => @fake_driver1
                @controller.send(:num).should == 1
            end
        end
    end

    describe "waiting for a ride request" do
        before :each do
            @fake_user1 = FactoryGirl.create(:user, "name" => "John Smith", "email" => "jsmith@colgate.edu", "birthday" => "1990-01-04", "driver" => @fake_driver1)
            @fake_user2 = FactoryGirl.create(:user, "name" => "Joe Buck", "email" => "jbuck@colgate.edu", "birthday" => "1990-02-04", "driver" => @fake_driver2)
            @fake_driver1 = FactoryGirl.create(:driver, "id" => "1", "user_id" => "1")
            @fake_driver2 = FactoryGirl.create(:driver, "id" => "2", "user_id" => "2")
            @num_waiting = 2
            @controller = DriversController.new
            @controller.should_receive(:num).and_return(@num_waiting)
            get :wait, :user_id => @fake_user2, :driver_id => @fake_driver2
        end
        it "should render the driver wait template" do
            response.should render_template('wait')
        end
        it "should make the number of waiting drivers available to the template" do
            assigns(:num_ahead).should == 1 
        end
    end
end
