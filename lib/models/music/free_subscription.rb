require_relative '../base_subscription'

module Music
  class FreeSubscription < BaseSubscription
    def initialize
      super(Constants::MUSIC_FREE_PLAN_PRICE, Constants::MUSIC_FREE_PLAN_VALIDITY)
    end
  end
end
