require 'rspec'
require 'date'
require 'spec_helper'
require_relative '../../../lib/enums/subscription_status'
require_relative '../../../lib/enums/topup'
require_relative '../../../lib/models/factories/subscription_factory'
require_relative '../../../lib/enums/subscription_category'
require_relative '../../../lib/enums/subscription_plan'
require_relative '../../../lib/models/doremi_subscription'

RSpec.describe DoremiSubscription do
  let(:subscription) { SubscriptionFactory.subscription(SubscriptionCategory::PODCAST, SubscriptionPlan::PERSONAL) }
  let(:doremi_subscription) { described_class.new }

  describe '#add_date_of_subscription' do
    it 'sets the start date and subscription status to started' do
      date = Date.today
      doremi_subscription.add_date_of_subscription(date)
      expect(doremi_subscription.start_date).to eq(date)
      expect(doremi_subscription.subscription_status).to eq(SubscriptionStatus::STARTED)
    end
  end

  describe '#add_subscription' do
    it 'adds a subscription to the subscription map' do
      doremi_subscription.add_subscription(SubscriptionCategory::PODCAST, subscription)
      expect(doremi_subscription.subscription_map[SubscriptionCategory::PODCAST]).to eq(subscription)
    end

    it 'sets the subscription status to added' do
      doremi_subscription.add_subscription(SubscriptionCategory::PODCAST, subscription)
      expect(doremi_subscription.subscription_status).to eq(SubscriptionStatus::ADDED)
    end
  end

  describe '#subscription_category_exist?' do
    it 'returns true if the subscription category exists' do
      doremi_subscription.add_subscription(SubscriptionCategory::PODCAST, subscription)
      expect(doremi_subscription.subscription_category_exist?(SubscriptionCategory::PODCAST)).to be(true)
    end

    it 'returns false if the subscription category does not exist' do
      expect(doremi_subscription.subscription_category_exist?(SubscriptionPlan::PREMIUM)).to be(false)
    end
  end

  describe '#add_devices' do
    let(:device) { double('Device') }

    it 'adds the device and sets the top up status to added' do
      doremi_subscription.add_devices(device, 6)
      expect(doremi_subscription.device).to eq(device)
      expect(doremi_subscription.top_up_status).to eq(Topup::ADDED)
      expect(doremi_subscription.no_of_months_for_top_up).to eq(6)
    end
  end
end
