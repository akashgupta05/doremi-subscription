require 'spec_helper'
require_relative '../../../../lib/models/factories/video_subscription_factory'
require_relative '../../../../lib/models/video/free_subscription'
require_relative '../../../../lib/models/video/personal_subscription'
require_relative '../../../../lib/models/video/premium_subscription'
require_relative '../../../../lib/enums/subscription_plan'
require_relative '../../../../lib/constants/constants'

RSpec.describe VideoSubscriptionFactory do
  describe '#subscription_plan' do
    context 'when subscription_plan_type is FREE' do
      it 'returns a FreeSubscription object' do
        plan_type = SubscriptionPlan::FREE
        plan_factory = VideoSubscriptionFactory.new
        expect(plan_factory.subscription_plan(plan_type)).to be_instance_of(Video::FreeSubscription)
      end
    end

    context 'when subscription_plan_type is PERSONAL' do
      it 'returns a PersonalSubscription object' do
        plan_type = SubscriptionPlan::PERSONAL
        plan_factory = VideoSubscriptionFactory.new
        expect(plan_factory.subscription_plan(plan_type)).to be_instance_of(Video::PersonalSubscription)
      end
    end

    context 'when subscription_plan_type is PREMIUM' do
      it 'returns a PremiumSubscription object' do
        plan_type = SubscriptionPlan::PREMIUM
        plan_factory = VideoSubscriptionFactory.new
        expect(plan_factory.subscription_plan(plan_type)).to be_instance_of(Video::PremiumSubscription)
      end
    end

    context 'when subscription_plan_type is invalid' do
      it 'returns nil' do
        plan_type = 'invalid'
        plan_factory = VideoSubscriptionFactory.new
        expect(plan_factory.subscription_plan(plan_type)).to be_nil
      end
    end
  end
end
