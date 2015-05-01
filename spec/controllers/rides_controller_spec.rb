require 'rails_helper'

RSpec.describe RidesController, type: :controller do
    context "check routes" do 
        before :each do
            @params = {"ride" => {"rider_id" => "1", "driver_id" => "1"}}
            @fake_driver = FactoryGirl.create(:driver, "id" => "1", "user_id" => "1")
            @fake_rider = FactoryGirl.create(:rider, "id" => "1", "user_id" => "2")
             @fake_user1 = FactoryGirl.create(:user, "id" => "1", "name" => "John Smith", "email" => "jsmith@colgate.edu", "birthday" => "1990-01-04", "driver" => @fake_driver1)
            @fake_user2 = FactoryGirl.create(:user, "id" => "2", "name" => "Joe Buck", "email" => "jbuck@colgate.edu", "birthday" => "1990-02-04", "driver" => @fake_driver2)
            @fake_ride = FactoryGirl.create(:ride, "id" => "1", "user_d_id" => "1", "user_r_id" => "2")
        end
        describe "POST #create" do
            it "routes to rides#create" do
                post :create, @params
                expect(response.status).to eq(302)
            end
        end
    end
    context "controller methods" do
        before :each do
            @params = {"ride" => {"rider_id" => "1", "driver_id" => "1"}}
            @fake_driver = FactoryGirl.create(:driver, "id" => "1", "user_id" => "1")
            @fake_rider = FactoryGirl.create(:rider, "id" => "1", "user_id" => "2")
             @fake_user1 = FactoryGirl.create(:user, "id" => "1", "name" => "John Smith", "email" => "jsmith@colgate.edu", "birthday" => "1990-01-04", "driver" => @fake_driver1)
            @fake_user2 = FactoryGirl.create(:user, "id" => "2", "name" => "Joe Buck", "email" => "jbuck@colgate.edu", "birthday" => "1990-02-04", "driver" => @fake_driver2)
            @fake_ride = FactoryGirl.create(:ride, "id" => 1, "user_d_id" => "1", "user_r_id" => "2")
        end
        
        describe "creating a ride" do

            it "should redirect to location on success" do
                Rider.should_receive(:find).with(@params["ride"]["rider_id"]).and_return(@fake_rider)
                Driver.should_receive(:find).with(@params["ride"]["driver_id"]).and_return(@fake_driver)
                Ride.should_receive(:new).and_return(@fake_ride)
                @fake_ride.should_receive(:save).and_return(true)
                post :create, @params
                response.should redirect_to(ride_set_location_path(@fake_ride))
            end
        end
        context "rider/driver exchange" do
            before :each do
                Ride.should_receive(:find).with("1").and_return(@fake_ride)
            end
            describe "update location" do
                it "should redirect to pickup rider path on success" do
                    @location_params = {"start_location" => "Frank", "end_location" => "Downtown"}
                    @fake_ride.should_receive(:update).with(@location_params).and_return(true)
                    patch :update_location, {:ride_id => @fake_ride, :ride => @location_params}
                    response.should redirect_to(ride_driver_enroute_path(@fake_ride))
                end
            end
            
            describe "update drive to pickup" do
                it "should should redirect to pickup rider on success" do
                    @fake_ride.should_receive(:save).and_return(true)
                    patch :update_drive_to_pickup, :ride_id => @fake_ride
                    response.should redirect_to(ride_pickup_rider_path(@fake_ride))
                end
            end

            describe "update pickup rider" do
                it "should should redirect to wait for rider confirm path on success" do
                    @fake_ride.should_receive(:save).and_return(true)
                    patch :update_pickup_rider, :ride_id => @fake_ride
                    response.should redirect_to(ride_wait_for_rider_confirm_path(@fake_ride))
                end
            end

            describe "update picked up" do
                it "should should redirect to wait for driver confirm path on success" do
                    @fake_ride.should_receive(:save).and_return(true)
                    patch :update_picked_up, :ride_id => @fake_ride
                    response.should redirect_to(ride_wait_for_driver_confirm_path(@fake_ride))
                end
            end

            describe "update dropoff rider" do
                it "should should redirect to wait for rider dropoff confirm path on success" do
						  User.should_receive(:find).with(1).and_return(@fake_user1)
						  @fake_ride.should_receive(:save).and_return(true)
                    patch :update_dropoff_rider, :ride_id => @fake_ride
                    response.should redirect_to(ride_wait_for_rider_dropoff_confirm_path(@fake_ride, :user_id=>@fake_user1))
                end
            end

            describe "dropped off" do
                it "should should redirect to wait for driver dropoff confirm path on success" do
						  User.should_receive(:find).with(2).and_return(@fake_user2)
                    @fake_ride.should_receive(:save).and_return(true)
                    patch :update_dropped_off, :ride_id => @fake_ride
                    response.should redirect_to(ride_wait_for_driver_dropoff_confirm_path(@fake_ride, :user_id=>@fake_user2))
                end
            end

        end
    end

end
