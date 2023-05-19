require_relative '../base_subscription'

module Podcast
  class FreeSubscription < BaseSubscription
    def initialize
      super(Constants::PODCAST_FREE_PLAN_PRICE, Constants::PODCAST_FREE_PLAN_VALIDITY)
    end
  end
end
