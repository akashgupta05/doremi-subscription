require 'spec_helper'
require 'date'
require_relative '../../../lib/services/renewal_service'
require_relative '../../../lib/models/doremi_subscription'
require_relative '../../../lib/models/music/free_subscription'
require_relative '../../../lib/models/music/personal_subscription'
require_relative '../../../lib/models/devices/four_devices_plan'

RSpec.describe RenewalService do
  describe '#calculate_renewal_dates' do
    let(:doremi_subscription) { DoremiSubscription.new }
    let(:date) { Date.strptime('07-04-2023', Constants::DATE_FORMAT) }
    subject { described_class.new(doremi_subscription) }

    context 'when subscriptions exist' do
      before do
        doremi_subscription.add_date_of_subscription(date)
        doremi_subscription.add_subscription(SubscriptionCategory::MUSIC, Music::PersonalSubscription.new)
      end

      it 'calculates renewal dates' do
        reminders = subject.calculate_renewal_dates

        expect(reminders.length).to eq(1)
        expect(reminders.first.subscription_category).to eq(SubscriptionCategory::MUSIC)
        expect(reminders.first.renewal_date.strftime(Constants::DATE_FORMAT)).to eq('27-04-2023')
      end
    end

    context 'when subscriptions do not exist' do
      it 'raises an error' do
        expect { subject.calculate_renewal_dates }.to raise_error(ErrorCode::SUBSCRIPTIONS_NOT_FOUND)
      end
    end
  end

  describe '#calculate_renewal_amount' do
    let(:doremi_subscription) { DoremiSubscription.new }
    subject { described_class.new(doremi_subscription) }
    let(:date) { Date.strptime('07-04-2023', Constants::DATE_FORMAT) }

    context 'when subscriptions and top up exist' do
      before do
        doremi_subscription.add_date_of_subscription(date)
        doremi_subscription.add_subscription(SubscriptionCategory::MUSIC, Music::PersonalSubscription.new)
      end

      it 'calculates renewal amount' do
        renewal_amount = subject.calculate_renewal_amount

        expect(renewal_amount.renewal_amount).to eq(Constants::MUSIC_PERSONAL_PLAN_PRICE)
      end
    end

    context 'when subscriptions do not exist' do
      it 'calculates renewal amount as 0' do
        renewal_amount = subject.calculate_renewal_amount

        expect(renewal_amount.renewal_amount).to eq(0)
      end
    end
  end
end
