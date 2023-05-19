require_relative '../base_subscription'

module Video
  class PersonalSubscription < BaseSubscription
    def initialize
      super(Constants::VIDEO_PERSONAL_PLAN_PRICE, Constants::VIDEO_PERSONAL_PLAN_VALIDITY)
    end
  end
end
