require 'spec_helper'
require_relative '../../../lib/enums/subscription_category'
require_relative '../../../lib/enums/subscription_plan'
require_relative '../../../lib/commands/add_subscription'

RSpec.describe Commands::AddSubscription do
  let(:subscription_service) { double('SubscriptionService') }
  let(:command) { described_class.new(subscription_service) }

  describe '#execute' do
    let(:inputs) { %w[ADD_SUBSCRIPTION MUSIC PERSONAL] }

    context 'with invalid arguments' do
      let(:inputs) { %w[ADD_SUBSCRIPTION MUSIC SOME] }

      before do
        allow(SubscriptionPlan).to receive(:const_get).with('SOME').and_raise('wrong constant name SOME')
      end

      it 'raises an error' do
        expect(subscription_service).not_to receive(:add_top_up)
        expect($stdout).to receive(:puts).with('wrong constant name SOME')
        command.execute(inputs)
      end
    end

    context 'when an error occurs' do
      let(:error_message) { 'An error occurred' }

      before do
        allow(subscription_service).to receive(:add_subscription_for_user).and_raise(error_message)
      end

      it 'outputs the error message to the console' do
        expect { command.execute(inputs) }.to output("#{error_message}\n").to_stdout
      end
    end

    context 'when the subscription is added successfully' do
      it 'calls #add_subscription_for_user on the subscription service' do
        expect(subscription_service).to receive(:add_subscription_for_user).with(
          SubscriptionCategory::MUSIC,
          SubscriptionPlan::PERSONAL
        )
        command.execute(inputs)
      end
    end
  end
end
