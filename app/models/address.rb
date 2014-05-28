class Address < ActiveRecord::Base
  validate :valid_ip, on: :create

  def valid_ip
    IPAddr.new(cidr)
  rescue IPAddr::InvalidAddressError, IPAddr::InvalidPrefixError, IPAddr::AddressFamilyError
    errors.add(:cidr, "is not valid")
  end
end
