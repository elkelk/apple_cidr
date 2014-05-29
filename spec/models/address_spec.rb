require 'spec_helper'

describe Address do
  subject(:address) { build(:address) }

  describe "validations" do
    it { should be_valid }

    it "validates format of ip address" do
      address.cidr = "not/valid"
      expect(address).to be_invalid
    end

    it "validates the uniqueness of the address" do
      create(:address)
      address.save
      expect(address).to be_invalid
    end
  end

  describe ".whitelisted" do
    before do
      create(:address, cidr: "192.168.2.0/24")
      create(:address, cidr: "192.168.8.0/12")
    end

    it "returns true if the address is whitelisted in any of the records" do
      expect(Address.whitelisted?("192.168.2.100")).to be_true
    end

    it "returns false if the address is not whitelisted in any of the records" do
      expect(Address.whitelisted?("190.168.2.100")).to be_false
    end

    it "returns false for an invalid entry" do
      expect(Address.whitelisted?("not/valid")).to be_false
    end
  end
end
