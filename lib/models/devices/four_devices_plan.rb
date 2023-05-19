require_relative '../base_device'
require_relative '../../constants/constants'

class FourDevicesPlan < BaseDevice
  def initialize
    super(Constants::UPTO_FOUR_DEVICES_PLAN_PRICE_PER_MONTH)
  end
end
