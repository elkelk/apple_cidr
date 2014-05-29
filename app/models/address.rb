class Address < ActiveRecord::Base
  validates :cidr, uniqueness: true
  validate :valid_ip

  ADDRESS_ERRORS = [ IPAddr::InvalidAddressError, IPAddr::InvalidPrefixError, IPAddr::AddressFamilyError ]

  def self.whitelisted?(ip_address)
    !!Address.all.find do |address|
      cidr = IPAddr.new(address.cidr)
      network_address = IPAddr.new(ip_address)
      cidr.include?(network_address)
    end
  rescue *ADDRESS_ERRORS
    false
  end

  private

  def valid_ip
    IPAddr.new(cidr)
  rescue *ADDRESS_ERRORS
    errors.add(:cidr, "is not valid")
  end
end
