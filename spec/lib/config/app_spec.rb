require 'spec_helper'
require_relative '../../../lib/config/app'

RSpec.describe App do
  let(:doremi_subscription) { instance_double(DoremiSubscription) }
  let(:subscription_service) do
    instance_double(SubscriptionService, add_subscription_for_user: {}, add_top_up: {}, start_subscription: {})
  end
  let(:renewal_service) { instance_double(RenewalService) }
  let(:start_subscription_command) { instance_double(Commands::StartSubscription, execute: nil) }
  let(:add_subscription_command) { instance_double(Commands::AddSubscription, execute: nil) }
  let(:add_top_up_command) { instance_double(Commands::AddTopUp, execute: nil) }
  let(:print_renewal_details_command) { instance_double(Commands::PrintRenewalDetails, execute: nil) }
  let(:command_session) { instance_double(Commands::Session, register_command: nil) }
  subject(:app) { described_class.new }

  before do
    allow(DoremiSubscription).to receive(:new).and_return(doremi_subscription)
    allow(SubscriptionService).to receive(:new).with(doremi_subscription).and_return(subscription_service)
    allow(RenewalService).to receive(:new).with(doremi_subscription).and_return(renewal_service)
    allow(Commands::StartSubscription).to receive(:new).with(subscription_service).and_return(start_subscription_command)
    allow(Commands::AddSubscription).to receive(:new).with(subscription_service).and_return(add_subscription_command)
    allow(Commands::AddTopUp).to receive(:new).with(subscription_service).and_return(add_top_up_command)
    allow(Commands::PrintRenewalDetails).to receive(:new).with(renewal_service).and_return(print_renewal_details_command)
    allow(Commands::Session).to receive(:new).and_return(command_session)
  end

  describe '#command_session' do
    it 'registers the start subscription command' do
      expect(command_session).to receive(:register_command).with(Commands::START_SUBSCRIPTION,
                                                                 start_subscription_command)
      app.command_session
    end

    it 'registers the add subscription command' do
      expect(command_session).to receive(:register_command).with(Commands::ADD_SUBSCRIPTION, add_subscription_command)
      app.command_session
    end

    it 'registers the add top up command' do
      expect(command_session).to receive(:register_command).with(Commands::ADD_TOPUP, add_top_up_command)
      app.command_session
    end

    it 'registers the print renewal details command' do
      expect(command_session).to receive(:register_command).with(Commands::PRINT_RENEWAL_DETAILS,
                                                                 print_renewal_details_command)
      app.command_session
    end

    it 'returns the command session' do
      expect(app.command_session).to eq command_session
    end
  end
end
