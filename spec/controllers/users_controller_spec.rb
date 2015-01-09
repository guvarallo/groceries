require 'spec_helper'

describe UsersController do

  describe 'GET new' do
    it "should set the @user variable" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe 'POST create' do
    context 'with valid inputs' do
    before { post :create, user: Fabricate.attributes_for(:user) }

      it "should create the user" do
        expect(User.count).to eq(1)
      end

      it "sets the flash" do
        should set_the_flash
      end

      it "redirects to tasks_path" do
        expect(response).to redirect_to tasks_path
      end

    end

    context 'with invalid inputs' do
      before { post :create, user: { email: "test@test.com", password: "pass" } }

      it "should not create an user" do
        expect(User.count).to eq(0)
      end

      it "renders new template" do
        should render_template(:new)
      end

      it "sets the @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end

    end
  end

end
