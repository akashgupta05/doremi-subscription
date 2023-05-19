require_relative '../enums/device'
require_relative '../constants/constants'
require_relative 'executor'

module Commands
  class AddTopUp < Commands::Executor
    def initialize(subscription_service)
      @subscription_service = subscription_service
    end

    def execute(inputs)
      device = Device.const_get(inputs[Constants::ONE])
      no_of_months = inputs[Constants::TWO].to_i
      @subscription_service.add_top_up(device, no_of_months)
    rescue StandardError => e
      puts e.message
    end
  end
end
