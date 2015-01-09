require 'spec_helper'

describe SessionsController do

  describe 'GET new' do

    it "renders new template if unauthenticated user" do
      get :new
      expect(response).to render_template :new
    end
    it "redirects to tasks_path if authenticated user" do
      set_current_user
      session[:user_id] = current_user.id
      get :new
      expect(response).to redirect_to root_path
    end
  end

  describe 'POST create' do
    let(:gus) { Fabricate(:user) }

    context "with valid inputs" do
      before { post :create, email: gus.email, password: gus.password }

      it "creates a session with the users id" do
        expect(session[:user_id]).to eq(gus.id)
      end

      it "sets the flash message" do
        should set_the_flash
      end

      it "redirects to root_path" do
        expect(response).to redirect_to tasks_path
      end
    end

    context "with invalid inputs" do
      before { post :create, email: "test@test.com", password: "test" }

      it "should not create a session" do
        expect(session[:user_id]).to be(nil)
      end

      it "sets the flash" do
        should set_the_flash
      end

      it "redirects to sign_in_path" do
        expect(response).to redirect_to sign_in_path
      end

    end
  end

  describe 'GET destroy' do
    before { session[:user_id] = Fabricate(:user).id }
    before { get :destroy }

    it "destroys the user session" do
      expect(session[:user_id]).to be(nil)
    end

    it "sets the flash" do
      should set_the_flash
    end

    it "redirects to root_path" do
      expect(response).to redirect_to root_path
    end

  end

end
