require_relative '../base_device'
require_relative '../../constants/constants'

class TenDevicesPlan < BaseDevice
  def initialize
    super(Constants::UPTO_TEN_DEVICES_PLAN_PRICE_PER_MONTH)
  end
end
