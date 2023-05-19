require_relative '../enums/subscription_category'
require_relative '../enums/subscription_plan'
require_relative '../constants/constants'
require_relative 'executor'

module Commands
  class AddSubscription < Commands::Executor
    def initialize(subscription_service)
      @subscription_service = subscription_service
    end

    def execute(inputs)
      subscription_category = SubscriptionCategory.const_get(inputs[Constants::ONE])
      subscription_plan = SubscriptionPlan.const_get(inputs[Constants::TWO])
      @subscription_service.add_subscription_for_user(subscription_category, subscription_plan)
    rescue StandardError => e
      puts e.message
    end
  end
end
