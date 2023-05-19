require_relative '../base_subscription'

module Music
  class PremiumSubscription < BaseSubscription
    def initialize
      super(Constants::MUSIC_PREMIUM_PLAN_PRICE, Constants::MUSIC_PREMIUM_PLAN_VALIDITY)
    end
  end
end
