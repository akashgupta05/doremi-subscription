require_relative '../base_subscription'

module Music
  class PersonalSubscription < BaseSubscription
    def initialize
      super(Constants::MUSIC_PERSONAL_PLAN_PRICE, Constants::MUSIC_PERSONAL_PLAN_VALIDITY)
    end
  end
end
