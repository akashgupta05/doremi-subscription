require_relative '../../enums/subscription_plan'
require_relative '../video/free_subscription'
require_relative '../video/personal_subscription'
require_relative '../video/premium_subscription'
require_relative 'abstract_plan_factory'

class VideoSubscriptionFactory < AbstractPlanFactory
  def subscription_plan(subscription_plan_type)
    case subscription_plan_type
    when SubscriptionPlan::FREE
      Video::FreeSubscription.new
    when SubscriptionPlan::PERSONAL
      Video::PersonalSubscription.new
    when SubscriptionPlan::PREMIUM
      Video::PremiumSubscription.new
    end
  end
end
