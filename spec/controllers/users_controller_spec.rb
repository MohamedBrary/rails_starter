require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  
  describe "GET #index as admin" do
    
    before do
      login_with create( :user, :admin )
    end

    after do
      Warden.test_reset!
    end

    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "loads all of the users into @users" do
    	User.where("id != ?",  controller.current_user.id).destroy_all # clear users table
      user1, user2 = create_pair(:user)
      get :index
      expect(assigns(:users)).to match_array([user1, user2, controller.current_user]) # used for login
    end
  end # of #index

end