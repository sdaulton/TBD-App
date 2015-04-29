require 'rails_helper'

describe RidersController do
    context "check routes" do 
        before :each do
            @params = {"user_id" => "1"}
            @fake_user = FactoryGirl.create(:user, "name" => "John Smith", "email" => "jsmith@colgate.edu", "birthday" => "1990-01-04")
            @fake_rider = FactoryGirl.create(:rider, "id" => "1", "user_id" => "1")
        end
        describe "POST #create" do
            it "routes to riders#create" do
                post :create, :user_id => @fake_user.id
                expect(response.status).to eq(302)
            end
        end

        describe "DELETE #destroy" do
            it "routes to riders#destroy" do
                delete :destroy, :user_id => @fake_user.id, :id => @fake_rider.id
                expect(response.status).to eq(302)
            end
        end

    end
    describe "adding a user to the ride list" do
        before :each do
           @params = {"user_id" => "1"}
           @fake_user = FactoryGirl.create(:user, "name" => "John Smith", "email" => "jsmith@colgate.edu", "birthday" => "1990-01-04")
           @fake_rider = FactoryGirl.create(:rider, "id" => "1", "user_id" => "1")
           User.should_receive(:find).with(@params["user_id"]).and_return(@fake_user)
           Rider.should_receive(:new).and_return(@fake_rider)
        end

        it "should redirect to wait on success" do
           @fake_rider.should_receive(:save).and_return(true)
           post :create, @params
           flash[:notice].should == "You are now waiting for a driver to become available."
           assigns(:user).rider.should == @fake_rider
           response.should redirect_to(user_rider_wait_path(@fake_user, @fake_rider))
        end

        it "should redirect to the user welcome page on failure" do
           @fake_rider.should receive(:save).and_return(nil)
           post :create, @params
           flash[:notice].should == "Failed to request a ride.  Please try again"
           response.should redirect_to(welcome_user_path(@fake_user))
        end
    end

    describe "deleting a user from the rider list" do
        before :each do
            @params = {"id" => "1"}
            @fake_user = FactoryGirl.create(:user, "name" => "John Smith", "email" => "jsmith@colgate.edu", "birthday" => "1990-01-04", "rider" => @fake_rider)
            @fake_rider = FactoryGirl.create(:rider, "id" => "1", "user_id" => "1")
            Rider.should_receive(:find).with(@params["id"]).and_return(@fake_rider)
            @fake_rider.should_receive(:destroy)
            delete :destroy, :user_id => @fake_user, :id => @fake_rider
        end
        it "should redirect to the user welcome page" do
            response.should redirect_to(welcome_user_path(:id => @fake_user))
        end
        it "should display the success message" do
            flash[:notice].should == "Not waiting for a ride."
        end
        it "should not be associated with the user" do
            @fake_user.rider.should == nil
        end

    end
    
    describe "test private controller methods" do
        before :each do
        
            @fake_user1 = FactoryGirl.create(:user, "name" => "John Smith", "email" => "jsmith@colgate.edu", "birthday" => "1990-01-04", "rider" => @fake_rider1)
            @fake_user2 = FactoryGirl.create(:user, "name" => "Joe Buck", "email" => "jbuck@colgate.edu", "birthday" => "1990-02-04", "rider" => @fake_rider2)
            @fake_rider1 = FactoryGirl.create(:rider, "id" => "1", "user_id" => "1")
            @fake_rider2 = FactoryGirl.create(:rider, "id" => "2", "user_id" => "2")
            @controller = RidersController.new
        end

        describe "getting the first user from the rider list" do
            before :each do
                Rider.should_receive(:first).and_return(@fake_rider1)
                User.should_receive(:find).with(@fake_rider1.user_id).and_return(@fake_user1)
            end
            it "should return the first user from the rider list" do
                @controller.send(:first).should == @fake_user1
            end
        end
    
        describe "getting the number of users waiting on the rider list" do
            before :each do
                Rider.should_receive(:count).and_return(2)
            end
            it "should return the number of users waiting on the list" do
                @controller.send(:num).should == 2
            end
        end
    end
    
    describe "waiting for a driver to become available" do
        before :each do
            @fake_user1 = FactoryGirl.create(:user, "name" => "John Smith", "email" => "jsmith@colgate.edu", "birthday" => "1990-01-04", "rider" => @fake_rider1)
            @fake_user2 = FactoryGirl.create(:user, "name" => "Joe Buck", "email" => "jbuck@colgate.edu", "birthday" => "1990-02-04", "rider" => @fake_rider2)
            @fake_rider1 = FactoryGirl.create(:rider, "id" => "1", "user_id" => "1")
            @fake_rider2 = FactoryGirl.create(:rider, "id" => "2", "user_id" => "2")
            @num_waiting = 2
            @controller = RidersController.new
            @controller.should_receive(:num).and_return(@num_waiting)
            Driver.should_receive(:count).and_return(0)
            get :wait, :user_id => @fake_user2, :rider_id => @fake_rider2
        end
        it "should render the rider wait template" do
            response.should render_template('wait')
        end
        it "should make the number of working drivers and the number of ride requests ahead available to the template" do
            assigns(:num_ahead).should == 1 
            assigns(:num_drivers).should == 0
        end
    end

    
end
