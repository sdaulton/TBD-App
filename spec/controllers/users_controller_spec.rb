require 'rails_helper'

RSpec.describe UsersController, type: :controller do

    describe "root route" do
        it "routes to users#index" do
            expect(:get => '/').to route_to(:controller => "users", :action => "index")
        end
    end

    describe "GET #index" do
        it "routes correctly" do
            get :index
            expect(response.status).to eq(200)
        end

    end
    
    describe "GET #login" do
        it "routes correctly" do
            get :login
            expect(response.status).to eq(200)
        end

        it "renders the login template" do
            get :login
            expect(response).to render_template(:login)
        end
    end

    describe "GET #register" do
        it "routes correctly" do
            get :register
            expect(response.status).to eq(200)
        end

        it "renders the welcome template" do
            get :register
            expect(response).to render_template(:register)
        end
    end
    
    describe "GET #welcome" do
        it "routes correctly" do
            u = User.new
            expect(User).to receive(:find).with("1") { u }
            get :welcome, id: 1
            expect(response.status).to eq(200)
        end

        it "renders the welcome template" do
            u = User.new
            expect(User).to receive(:find).with("1") { u }
            get :welcome, id: 1
            expect(response).to render_template(:welcome)
        end
    end
    
    describe 'signing in' do
        context 'user account exists' do
            it 'should select welcome page for rendering'
            it 'should make the user available to the welcome template'
        end
        context 'user account does not exist' do
            it 'should select the register page for rendering'
            it 'should make the user available to the register template'
        end

    end

    describe 'editing/updating account information' do
        before :each do
            @params = {"user"=>{"name"=>"John Smith", "email"=>"jsmith@colgate.edu", "birthday"=>"1986-01-03", "driver"=>"1"}, "commit"=>"Update user", "id" => "1"}
            @fake_user = FactoryGirl.create(:user, "name" => "John Smith", "email" => "jsmith@colgate.edu", "birthday" => "1990-01-04", "driver" => "1")
            User.should_receive(:find).with(@params["id"]).and_return(@fake_user)
        end
        it 'should select the edit page for rendering' do
            get :edit, @params
            response.should render_template('edit') 
        end

        it 'should call the find and update user model methods' do
            @fake_user.should_receive(:update).with({"name" => "John Smith", "email" => "jsmith@colgate.edu", "birthday" => "1986-01-03", "driver" => "1"})
            put :update, @params
            flash[:notice].should == "John Smith was successfully updated"
            response.should redirect_to(welcome_user_path(@fake_user))
        end
    end

    

end

