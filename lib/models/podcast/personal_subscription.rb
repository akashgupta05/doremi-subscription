require_relative '../base_subscription'
require_relative '../../constants/constants'

module Podcast
  class PersonalSubscription < BaseSubscription
    def initialize
      super(Constants::PODCAST_PERSONAL_PLAN_PRICE, Constants::PODCAST_PERSONAL_PLAN_VALIDITY)
    end
  end
end
