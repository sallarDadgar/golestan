describe FieldPolicy do
  subject { described_class }

  permissions :create?, :update?, :show?, :destroy? do
    it "grants access if user is an admin" do
      expect(subject).to permit(User.new(role: :admin))
    end

    it "denies access if user is not admin" do
      expect(subject).not_to permit(User.new(role: :student))
      expect(subject).not_to permit(User.new(role: :prof))
    end
  end

  permissions :index? do
    it "grants access to all users" do
      expect(subject).to permit(User.new(role: :admin))
      expect(subject).to permit(User.new(role: :prof))
      expect(subject).to permit(User.new(role: :student))
    end
  end
end