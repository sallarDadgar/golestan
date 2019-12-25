describe StusonPolicy do
  subject { described_class }

  permissions :create? do
    it "grants access if user is an admin or student" do
      expect(subject).to permit(User.new(role: :admin))
      expect(subject).to permit(User.new(role: :student))
    end
    it "denies access if user is prof" do
      expect(subject).not_to permit(User.new(role: :prof))
    end
  end

  permissions :update?, :show? do
    it "grants access if user is an prof" do
      expect(subject).to permit(User.new(role: :prof))
    end

    it "denies access if user is not prof" do
      expect(subject).not_to permit(User.new(role: :student))
      expect(subject).not_to permit(User.new(role: :admin))
    end
  end

  permissions :index? do
    it "grants access if user is a prof or a student" do
      expect(subject).to permit(User.new(role: :prof))
      expect(subject).to permit(User.new(role: :student))
    end

    it "denies access if user is admin" do
      expect(subject).not_to permit(User.new(role: :admin))
    end
  end
end