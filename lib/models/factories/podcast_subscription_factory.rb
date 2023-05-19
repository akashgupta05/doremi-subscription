require_relative '../../enums/subscription_plan'
require_relative '../podcast/free_subscription'
require_relative '../podcast/personal_subscription'
require_relative '../podcast/premium_subscription'
require_relative 'abstract_plan_factory'

class PodcastSubscriptionFactory < AbstractPlanFactory
  def subscription_plan(subscription_plan_type)
    case subscription_plan_type
    when SubscriptionPlan::FREE
      Podcast::FreeSubscription.new
    when SubscriptionPlan::PERSONAL
      Podcast::PersonalSubscription.new
    when SubscriptionPlan::PREMIUM
      Podcast::PremiumSubscription.new
    end
  end
end
