require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = User.new(email: 'user@example.com') }
  subject { @user }
  it { should respond_to(:email) }
  it { should be_valid }

  describe "when email format is invalid" do
    before { @user.email = "user_at_exemple.com" }
    it { should_not be_valid }
  end

  describe "when email format is valid" do
    it { should be_valid }
  end
end
