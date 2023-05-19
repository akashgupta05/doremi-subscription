require 'spec_helper'
require_relative '../../../../lib/models/factories/podcast_subscription_factory'
require_relative '../../../../lib/models/podcast/free_subscription'
require_relative '../../../../lib/models/podcast/personal_subscription'
require_relative '../../../../lib/models/podcast/premium_subscription'
require_relative '../../../../lib/enums/subscription_plan'
require_relative '../../../../lib/constants/constants'

describe PodcastSubscriptionFactory do
  describe '#subscription_plan' do
    context 'when subscription plan is free' do
      it 'returns a FreeSubscription object' do
        subscription_plan_type = SubscriptionPlan::FREE
        plan_factory = PodcastSubscriptionFactory.new
        plan = plan_factory.subscription_plan(subscription_plan_type)
        expect(plan).to be_a(Podcast::FreeSubscription)
      end
    end

    context 'when subscription plan is personal' do
      it 'returns a PersonalSubscription object' do
        subscription_plan_type = SubscriptionPlan::PERSONAL
        plan_factory = PodcastSubscriptionFactory.new
        plan = plan_factory.subscription_plan(subscription_plan_type)
        expect(plan).to be_a(Podcast::PersonalSubscription)
      end
    end

    context 'when subscription plan is premium' do
      it 'returns a PremiumSubscription object' do
        subscription_plan_type = SubscriptionPlan::PREMIUM
        plan_factory = PodcastSubscriptionFactory.new
        plan = plan_factory.subscription_plan(subscription_plan_type)
        expect(plan).to be_a(Podcast::PremiumSubscription)
      end
    end

    context 'when subscription plan is invalid' do
      it 'returns nil' do
        subscription_plan_type = 'invalid'
        plan_factory = PodcastSubscriptionFactory.new
        expect(plan_factory.subscription_plan(subscription_plan_type)).to be_nil
      end
    end
  end
end
