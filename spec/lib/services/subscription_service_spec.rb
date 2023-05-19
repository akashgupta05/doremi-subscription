require 'spec_helper'
require 'rspec'
require_relative '../../../lib/models/doremi_subscription'
require_relative '../../../lib/services/subscription_service'
require_relative '../../../lib/enums/device'

RSpec.describe SubscriptionService do
  let(:subscription) { DoremiSubscription.new }
  let(:subscription_service) { SubscriptionService.new(subscription) }

  describe '#start_subscription' do
    it 'adds starting date to subscription' do
      subscription_service.start_subscription('07-05-2023')
      expect(subscription.start_date).to eq(Date.new(2023, 5, 7))
    end

    it 'raises error for invalid date string' do
      expect { subscription_service.start_subscription('05-32-2023') }.to raise_error(ErrorMessage::INVALID_DATE)
    end
  end

  describe '#add_subscription_for_user' do
    it 'adds subscription to subscription category' do
      subscription_service.start_subscription('07-05-2023')
      subscription_service.add_subscription_for_user(SubscriptionCategory::VIDEO, SubscriptionPlan::PERSONAL)
      expect(subscription.subscription_map[SubscriptionCategory::VIDEO]).to be_instance_of(Video::PersonalSubscription)
    end

    it 'raises error for duplicate subscription category' do
      subscription_service.start_subscription('07-05-2023')
      subscription_service.add_subscription_for_user(SubscriptionCategory::MUSIC, SubscriptionPlan::PERSONAL)
      expect do
        subscription_service.add_subscription_for_user(SubscriptionCategory::MUSIC, SubscriptionPlan::PREMIUM)
      end.to raise_error("#{ErrorCode::ADD_SUBSCRIPTION_FAILED} #{ErrorMessage::DUPLICATE_CATEGORY}")
    end

    it 'raises error for pending subscription status' do
      expect do
        subscription_service.add_subscription_for_user(SubscriptionCategory::MUSIC, SubscriptionPlan::PERSONAL)
      end.to raise_error("#{ErrorCode::ADD_SUBSCRIPTION_FAILED} #{ErrorMessage::INVALID_DATE}")
    end
  end

  describe '#add_top_up' do
    it 'adds devices for valid subscription status' do
      subscription_service.start_subscription('07-05-2023')
      subscription_service.add_subscription_for_user(SubscriptionCategory::MUSIC, SubscriptionPlan::PERSONAL)

      subscription_service.add_top_up(Device::FOUR_DEVICE, 3)
      expect(subscription.device).not_to be_nil
      expect(subscription.device.price).to eq(50)
    end

    it 'raises error for duplicate top-up' do
      subscription_service.start_subscription('07-05-2023')
      subscription_service.add_subscription_for_user(SubscriptionCategory::MUSIC, SubscriptionPlan::PERSONAL)

      subscription_service.add_top_up(Device::FOUR_DEVICE, 3)
      expect do
        subscription_service.add_top_up(Device::FOUR_DEVICE, 3)
      end.to raise_error("#{ErrorCode::ADD_TOPUP_FAILED} #{ErrorMessage::DUPLICATE_TOPUP}")
    end

    it 'raises error for invalid subscription status' do
      expect do
        subscription_service.add_top_up(Device::FOUR_DEVICE, 3)
      end.to raise_error("#{ErrorCode::ADD_TOPUP_FAILED} #{ErrorMessage::INVALID_DATE}")

      subscription_service.start_subscription('07-05-2023')
      expect do
        subscription_service.add_top_up(Device::FOUR_DEVICE, 3)
      end.to raise_error("#{ErrorCode::ADD_TOPUP_FAILED} #{ErrorCode::SUBSCRIPTIONS_NOT_FOUND}")
    end
  end
end
