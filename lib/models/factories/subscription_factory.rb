require_relative '../../enums/subscription_category'
require_relative 'podcast_subscription_factory'
require_relative 'music_subscription_factory'
require_relative 'video_subscription_factory'

class SubscriptionFactory
  def self.subscription_category_factory(subscription_category_type)
    case subscription_category_type
    when SubscriptionCategory::PODCAST
      PodcastSubscriptionFactory.new
    when SubscriptionCategory::MUSIC
      MusicSubscriptionFactory.new
    when SubscriptionCategory::VIDEO
      VideoSubscriptionFactory.new
    end
  end

  def self.subscription(subscription_category_type, subscription_plan_type)
    abstract_plan_factory = SubscriptionFactory.subscription_category_factory(subscription_category_type)
    raise 'Invalid Subscription Category' if abstract_plan_factory.nil?

    subscription = abstract_plan_factory.subscription_plan(subscription_plan_type)
    raise 'Invalid Subscription Plan' if subscription.nil?

    subscription
  end
end
