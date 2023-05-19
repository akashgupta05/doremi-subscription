require_relative '../../enums/subscription_plan'
require_relative '../music/free_subscription'
require_relative '../music/personal_subscription'
require_relative '../music/premium_subscription'
require_relative 'abstract_plan_factory'

class MusicSubscriptionFactory < AbstractPlanFactory
  def subscription_plan(subscription_plan_type)
    case subscription_plan_type
    when SubscriptionPlan::FREE
      Music::FreeSubscription.new
    when SubscriptionPlan::PERSONAL
      Music::PersonalSubscription.new
    when SubscriptionPlan::PREMIUM
      Music::PremiumSubscription.new
    end
  end
end
