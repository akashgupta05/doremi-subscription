require 'spec_helper'
require_relative '../../../../lib/models/factories/music_subscription_factory'
require_relative '../../../../lib/models/music/free_subscription'
require_relative '../../../../lib/models/music/personal_subscription'
require_relative '../../../../lib/models/music/premium_subscription'
require_relative '../../../../lib/enums/subscription_plan'
require_relative '../../../../lib/constants/constants'

RSpec.describe MusicSubscriptionFactory do
  describe '#subscription_plan' do
    it "returns Music::FreeSubscription object for subscription plan type 'free'" do
      plan_factory = MusicSubscriptionFactory.new
      subscription_plan_type = SubscriptionPlan::FREE
      subscription_plan = plan_factory.subscription_plan(subscription_plan_type)
      expect(subscription_plan).to be_instance_of(Music::FreeSubscription)
    end

    it "returns Music::PersonalSubscription object for subscription plan type 'personal'" do
      plan_factory = MusicSubscriptionFactory.new
      subscription_plan_type = SubscriptionPlan::PERSONAL
      subscription_plan = plan_factory.subscription_plan(subscription_plan_type)
      expect(subscription_plan).to be_instance_of(Music::PersonalSubscription)
    end

    it "returns Music::PremiumSubscription object for subscription plan type 'premium'" do
      plan_factory = MusicSubscriptionFactory.new
      subscription_plan_type = SubscriptionPlan::PREMIUM
      subscription_plan = plan_factory.subscription_plan(subscription_plan_type)
      expect(subscription_plan).to be_instance_of(Music::PremiumSubscription)
    end

    context 'when subscription plan is invalid' do
      it 'returns nil' do
        subscription_plan_type = 'invalid'
        plan_factory = MusicSubscriptionFactory.new
        expect(plan_factory.subscription_plan(subscription_plan_type)).to be_nil
      end
    end
  end
end
