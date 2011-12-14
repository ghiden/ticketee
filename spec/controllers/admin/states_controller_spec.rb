require 'spec_helper'

describe Admin::StatesController do
  let(:user)    { create_user!(:admin => true) }
  let(:project) { Factory(:project) }
  let(:ticket)  { Factory(:ticket, :project => project, :user => user) }
  let(:state)   { Factory(:state) }

  context "not assigned state" do
    before do
      sign_in(:user, user)
    end

    it "can edit a state not assigned to tickets" do
      get :edit, :id => state.id
      response.should be_success
    end

    it "can update a state assigned to tickets" do
      put :update, {:id => state.id, :name => 'dummy dummy'}
      response.should redirect_to(admin_states_path)
      flash[:notice].should eql("State has been updated.")
    end

    it "can delete a state assigned to tickets" do
      delete :destroy, :id => state.id
      response.should redirect_to(admin_states_path)
      flash[:notice].should eql("State has been deleted.")
    end
  end

  context "assigned state" do
    before do
      sign_in(:user, user)
      comment = Factory(:comment, 
                        :ticket => ticket, :user => user, :state => state)
    end

    it "cannot edit a state assigned to tickets" do
      get :edit, :id => state.id
      response.should redirect_to(admin_states_path)
      flash[:alert].should eql("State has tickets assigned.")
    end

    it "cannot update a state assigned to tickets" do
      put :update, {:id => state.id, :name => 'dummy dummy'}
      response.should redirect_to(admin_states_path)
      flash[:alert].should eql("State has tickets assigned.")
    end

    it "cannot delete a state assigned to tickets" do
      delete :destroy, :id => state.id
      response.should redirect_to(admin_states_path)
      flash[:alert].should eql("State has tickets assigned.")
    end

  end
end

=begin
describe TicketsController do
  let(:user)    { create_user! }
  let(:project) { Factory(:project) }
  let(:ticket)  { Factory(:ticket, :project => project, :user => user) }

  context "standard users" do
    it "cannot access a ticket for a project" do
      sign_in(:user, user)
      get :show, :id => ticket.id, :project_id => project.id
      response.should redirect_to(root_path)
      flash[:alert].should eql("The project you were looking for could not be found.")
    end

    context "with permission to view the project" do
      before do
        sign_in(:user, user)
        Permission.create!(:user => user, :thing => project, :action => "view")
      end

      def cannot_create_tickets!
        response.should redirect_to(project)
        flash[:alert].should eql("You cannot create tickets on this project.")
      end

      def cannot_update_tickets!
        response.should redirect_to(project)
        flash[:alert].should eql("You cannot edit tickets on this project.")
      end

      it "cannot begin to create a ticket" do
        get :new, :project_id => project.id
        cannot_create_tickets!
      end

      it "cannot create a ticket without permission" do
        post :create, :project_id => project.id
        cannot_create_tickets!
      end

      it "cannot edit a ticket without permission" do
        get :edit, {:project_id => project.id, :id => ticket.id}
        cannot_update_tickets!
      end

      it "cannot update a ticket without permission" do
        put :update, { 
          :project_id => project.id,
          :id => ticket.id,
          :ticket => {}
        }
        cannot_update_tickets!
      end

      it "cannot delete a ticket without permission" do
        delete :destroy, {:project_id => project.id, :id => ticket.id}
        response.should redirect_to(project)
        flash[:alert].should eql("You cannot delete tickets from this project.")
      end
    end
  end

end
=end
