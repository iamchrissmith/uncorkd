require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    context "invalid attributes" do
      it { should have_secure_password }
      it { should validate_presence_of(:first_name) }
      it { should validate_presence_of(:last_name) }
      it { should validate_presence_of(:email) }
      it { should validate_presence_of(:username) }
      it { should validate_uniqueness_of(:username) }
      it { should validate_presence_of(:phone_number) }
    end

    context "valid attributes" do
      it "is valid with a first name, last name, username, email, phone number and password" do
        user = create(:user)

        expect(user).to be_valid
      end
    end
  end

  context "relationships" do
    xit "belongs to ..." do
      user = create(:user)

      expect(user).to respond_to(:model)
    end

    xit "has many ..." do
      user = User.new(
                      first_name: "Mason",
                      last_name: "Tom",
                      email: "mason@tom.com",
                      username: "ToMas",
                      phone_number: "303-111-2222",
                      password: "Password"
                      )

      expect(user).to respond_to(:model)
    end
  end

  context "Factory" do
    it "should be a user" do
      expect(create(:user)).to be_a(User)
    end

    it "should have attributes" do
      user = create(:user)
      expect(user.first_name).to be_a(String)
      expect(user.last_name).to be_a(String)
      expect(user.username).to be_a(String)
      expect(user.email).to be_a(String)
      expect(user.bio).to be_a(String)
      expect(user.phone_number).to be_a(String)
      expect(user.password).to be_a(String)
    end
  end
end
