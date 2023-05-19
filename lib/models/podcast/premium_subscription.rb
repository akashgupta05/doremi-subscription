require_relative '../base_subscription'

module Podcast
  class PremiumSubscription < BaseSubscription
    def initialize
      super(Constants::PODCAST_PREMIUM_PLAN_PRICE, Constants::PODCAST_PREMIUM_PLAN_VALIDITY)
    end
  end
end
