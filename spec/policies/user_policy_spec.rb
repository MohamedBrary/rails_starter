describe UserPolicy, type: :policy do
  subject { UserPolicy }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:current_user_persisted) { FactoryGirl.create :user }
  let (:other_user_persisted) { FactoryGirl.create :user }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }
  let (:manager) { FactoryGirl.build_stubbed :user, :manager }

  permissions :index? do
    it "denies access if not an admin or manager" do
      expect(UserPolicy).not_to permit(current_user)
    end
    it "allows access for an admin or manager" do
      expect(UserPolicy).to permit(manager)
      expect(UserPolicy).to permit(admin)
    end
  end

  # we need persisted user, because we check against the database
  permissions :show? do
    it "prevents other users from seeing your profile" do
      expect(subject).not_to permit(current_user_persisted, other_user_persisted)
    end
    it "allows you to see your own profile" do
      expect(subject).to permit(current_user_persisted, current_user_persisted)
    end
    it "allows an admin or manager to see any profile" do
      expect(subject).to permit(admin, other_user_persisted)
      expect(subject).to permit(manager, other_user_persisted)
    end
  end

  permissions :update? do
    it "allows an admin to make updates" do
      expect(subject).to permit(admin, other_user)
    end
    it "allows user to update himself" do
      expect(subject).to permit(current_user, current_user)
    end
    it "prevents user from updating another users" do
      expect(subject).not_to permit(current_user, other_user)
    end    
    it "allows an admin or manager to update any user" do
      expect(subject).to permit(admin, other_user)
      expect(subject).to permit(manager, other_user)
    end
  end

  permissions :destroy? do
    # currently user is allowed to delete himself
    # it "prevents deleting yourself" do
    #   expect(subject).not_to permit(current_user, current_user)
    # end
    it "allows user to delete himself" do
      expect(subject).to permit(current_user, current_user)
    end
    it "prevents user from deleting another users" do
      expect(subject).not_to permit(current_user, other_user)
    end    
    it "allows an admin or manager to delete any user" do
      expect(subject).to permit(admin, other_user)
      expect(subject).to permit(manager, other_user)
    end
  end

end