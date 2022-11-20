require "rails_helper"

RSpec.describe User, :type => :model do
  subject(:user) { build(:user) }

  after(:context) do
    DatabaseCleaner.clean
  end
  
  describe 'validations' do 
    specify 'validate presence of email, first_name, last_name, phone_number' do
      expect(user).to validate_presence_of(:email).on(:create)
      expect(user).to validate_presence_of(:last_name).on(:create)
      expect(user).to validate_presence_of(:last_name).on(:create)
      expect(user).to validate_presence_of(:mobile_number).on(:create)
    end

    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  it "is valid with valid attributes" do
    @user1 = create(:user)
    expect(@user1).to be_valid
  end
  
  it "has a unique email" do
    @user1 = create(:user)
    user2 = build(:user, email: @user1.email)
    expect(user2).not_to be_valid
  end

  it "has a unique mobile_number" do
    @user1 = create(:user)
    user2 = build(:user, mobile_number: @user1.mobile_number)
    expect(user2).not_to be_valid
  end

  it "is not valid without a password" do
    @user1 = create(:user)
    user2 = build(:user, password: nil)
    expect(user2).not_to be_valid
  end
  
  it "is not valid without an email" do
    @user1 = create(:user)
    user2 = build(:user, email: nil)
    expect(user2).not_to be_valid
  end
end
