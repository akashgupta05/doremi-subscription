require_relative '../base_subscription'

module Video
  class FreeSubscription < BaseSubscription
    def initialize
      super(Constants::VIDEO_FREE_PLAN_PRICE, Constants::VIDEO_FREE_PLAN_VALIDITY)
    end
  end
end
