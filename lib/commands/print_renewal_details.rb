require_relative 'executor'

module Commands
  class PrintRenewalDetails < Commands::Executor
    def initialize(renewal_service)
      @renewal_service = renewal_service
    end

    def execute(_intputs)
      renewal_reminders = @renewal_service.calculate_renewal_dates
      renewal_amount = @renewal_service.calculate_renewal_amount
      renewal_reminders.each { |renewal_reminder| puts renewal_reminder }
      puts renewal_amount
    rescue StandardError => e
      puts e.message
    end
  end
end
