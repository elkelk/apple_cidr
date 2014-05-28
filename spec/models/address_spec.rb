require 'spec_helper'

describe Address do
  subject(:address) { build(:address) }

  describe "validations" do
    it { should be_valid }

    it "validates format of ip address" do
      address.cidr = "not/valid"
      expect(address).to be_invalid
    end
  end
end
