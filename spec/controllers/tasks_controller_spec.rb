require 'spec_helper'

describe TasksController do

  before { set_current_user }

  describe 'GET index' do

    it "sets @incomplete_tasks with the users tasks" do
      task1 = Fabricate(:task, user: current_user)
      task2 = Fabricate(:task, user: current_user)
      get :index
      expect(assigns :incomplete_tasks).to match_array([task1, task2])
    end

    it "cannot see other users tasks" do
      gus = Fabricate(:user)
      task1 = Fabricate(:task, user: gus)
      task2 = Fabricate(:task, user: gus)
      get :index
      expect(assigns :incomplete_tasks).not_to match_array([task1, task2])
    end

    it_behaves_like "require_sign_in" do
      let(:action) { get :index }
    end

  end

  describe 'GET new' do

    it "sets the @task variable" do
      get :new
      expect(assigns(:task)).to be_instance_of(Task)
    end

    it_behaves_like "require_sign_in" do
      let(:action) { get :new }
    end

  end

  describe 'POST create' do

    it_behaves_like "require_sign_in" do
      let(:action) { post :create }
    end

    context 'with valid input' do

      it "creates a new task" do
        post :create, task: Fabricate.attributes_for(:task)
        expect(Task.count).to eq(1)
      end

      it "creates a new task associated with the current user" do
        post :create, task: Fabricate.attributes_for(:task)
        expect(Task.first.user).to eq(current_user)
      end

      it "redirects to tasks_path" do
        post :create, task: Fabricate.attributes_for(:task)
        expect(response).to redirect_to tasks_path
      end

    end

    context 'with invalid input' do
      before { post :create, task: { description: "" } }

      it "should not create a new task" do
        expect(Task.count).to eq(0)
      end

    end
  end

  describe 'PATCH update' do
    let!(:task) { Fabricate(:task, user: current_user) }
    before { patch :update, id: task.id, task: { description: "Updated!" } }

    it_behaves_like "require_sign_in" do
      let(:action) { patch :update, id: task.id }
    end

    it "updates the task" do
      expect(Task.first.description).to eq("Updated!")
    end

    it "redirects to tasks_path" do
      expect(response).to redirect_to tasks_path
    end

    it "does not update other user's task" do
      gus = Fabricate(:user)
      todo = Task.create(description: "Original", user: gus)
      patch :update, id: todo.id, task: { description: "Updated!" }
      expect(Task.last.description).to eq("Original")
    end

  end

  describe 'DELETE destroy' do
    let!(:task) { Fabricate(:task, user: current_user) }
    before { delete :destroy, id: task.id }

    it "deletes the task" do
      expect(Task.count).to eq(0)
    end

    it "redirects to tasks_path" do
      expect(response).to redirect_to tasks_path
    end

    it "does not delete other user's task" do
      gus = Fabricate(:user)
      todo = Task.create(description: "Original", user: gus)
      delete :destroy, id: todo.id
      expect(Task.last.description).to eq("Original")
    end

  end

end
