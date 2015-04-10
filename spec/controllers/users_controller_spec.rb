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
end
