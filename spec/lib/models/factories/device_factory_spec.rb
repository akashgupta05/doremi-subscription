require 'spec_helper'
require_relative '../../../../lib/models/factories/device_factory'
require_relative '../../../../lib/models/devices/four_devices_plan'
require_relative '../../../../lib/enums/device'

RSpec.describe DeviceFactory do
  describe '.device' do
    context 'when given four device type' do
      it 'returns an instance of FourDevicesPlan' do
        device = DeviceFactory.device(Device::FOUR_DEVICE)
        expect(device).to be_an_instance_of(FourDevicesPlan)
      end
    end

    context 'when given ten device type' do
      it 'returns an instance of TenDevicesPlan' do
        device = DeviceFactory.device(Device::TEN_DEVICE)
        expect(device).to be_an_instance_of(TenDevicesPlan)
      end
    end

    context 'when given invalid device type' do
      it 'returns nil' do
        expect(DeviceFactory.device('invalid_type')).to be_nil
      end
    end
  end
end
