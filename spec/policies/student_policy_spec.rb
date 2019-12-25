describe StudentPolicy do
  subject { described_class }

  permissions :index?, :create?, :update?, :destroy? do
    it "grants access if user is an admin" do
      expect(subject).to permit(User.new(role: :admin))
    end

    it "denies access if user is not admin" do
      expect(subject).not_to permit(User.new(role: :student))
      expect(subject).not_to permit(User.new(role: :prof))
    end
  end


  permissions :show? do
    it "grants access if user is an admin or a prof" do
      expect(subject).to permit(User.new(role: :admin))
      expect(subject).to permit(User.new(role: :prof))
    end

    it "denies access if user is student" do
      expect(subject).not_to permit(User.new(role: :student))
    end
  end
end