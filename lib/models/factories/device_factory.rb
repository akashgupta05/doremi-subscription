require_relative '../../enums/device'
require_relative '../devices/four_devices_plan'
require_relative '../devices/ten_devices_plan'

class DeviceFactory
  def self.device(type)
    case type
    when Device::FOUR_DEVICE
      FourDevicesPlan.new
    when Device::TEN_DEVICE
      TenDevicesPlan.new
    end
  end
end
