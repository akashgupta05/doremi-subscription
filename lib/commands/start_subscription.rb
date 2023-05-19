require_relative 'executor'

module Commands
  class StartSubscription < Commands::Executor
    def initialize(subscription_service)
      @subscription_service = subscription_service
    end

    def execute(inputs)
      date_str = inputs[Constants::ONE]
      @subscription_service.start_subscription(date_str)
    rescue StandardError => e
      puts e.message
    end
  end
end
