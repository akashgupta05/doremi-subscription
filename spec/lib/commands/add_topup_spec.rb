require 'spec_helper'
require_relative '../../../lib/commands/add_top_up'

RSpec.describe Commands::AddTopUp do
  let(:subscription_service) { double('SubscriptionService') }
  subject(:command) { described_class.new(subscription_service) }

  describe '#execute' do
    context 'with invalid arguments' do
      let(:inputs) { %w[ADD_TOP_UP ONE 6] }

      before do
        allow(Device).to receive(:const_get).with('ONE').and_raise('wrong constant name ONE')
      end

      it 'raises an error' do
        expect(subscription_service).not_to receive(:add_top_up)
        expect($stdout).to receive(:puts).with('wrong constant name ONE')
        command.execute(inputs)
      end
    end

    context 'with valid arguments' do
      let(:inputs) { %w[ADD_TOP_UP FOUR_DEVICE 6] }
      let(:device) { 0 }
      let(:no_of_months) { 6 }

      before do
        allow(Device).to receive(:const_get).with('FOUR_DEVICE').and_return(device)
        allow(subscription_service).to receive(:add_top_up).with(device, no_of_months)
      end

      it 'calls the add_topup method on the subscription service' do
        command.execute(inputs)
        expect(subscription_service).to have_received(:add_top_up).with(device, no_of_months)
      end
    end
  end
end
