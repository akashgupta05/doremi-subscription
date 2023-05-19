require 'spec_helper'
require_relative '../../../lib/commands/start_subscription'
require_relative '../../../lib/services/subscription_service'

RSpec.describe Commands::StartSubscription do
  let(:subscription_service) { double(SubscriptionService) }
  let(:command) { described_class.new(subscription_service) }

  describe '#execute' do
    context 'with invalid arguments' do
      let(:inputs) { %w[START_SUBSCRIPTION INVALID_DATE] }

      before do
        allow(subscription_service).to receive(:start_subscription).and_raise('INVALID_DATE')
      end

      it 'raises an error' do
        expect($stdout).to receive(:puts).with('INVALID_DATE')
        command.execute(inputs)
      end
    end

    context 'with valid arguments' do
      let(:inputs) { %w[START_SUBSCRIPTION 01-05-2023] }
      let(:date_str) { '01-05-2023' }

      before do
        allow(subscription_service).to receive(:start_subscription).with(date_str)
      end

      it 'calls the start_subscription method on the subscription service' do
        command.execute(inputs)
        expect(subscription_service).to have_received(:start_subscription).with(date_str)
      end
    end
  end
end
