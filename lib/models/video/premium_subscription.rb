require_relative '../base_subscription'

module Video
  class PremiumSubscription < BaseSubscription
    def initialize
      super(Constants::VIDEO_PREMIUM_PLAN_PRICE, Constants::VIDEO_PREMIUM_PLAN_VALIDITY)
    end
  end
end
