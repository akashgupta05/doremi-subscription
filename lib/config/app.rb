require_relative '../models/doremi_subscription'
require_relative '../services/subscription_service'
require_relative '../services/renewal_service'
require_relative '../commands/start_subscription'
require_relative '../commands/add_subscription'
require_relative '../commands/add_top_up'
require_relative '../commands/print_renewal_details'
require_relative '../commands/session'
require_relative '../commands/commands'

class App
  def initialize
    @doremi_subscription = DoremiSubscription.new
    @subscription_service = SubscriptionService.new(@doremi_subscription)
    @renewal_service = RenewalService.new(@doremi_subscription)
    @start_subscription_command = Commands::StartSubscription.new(@subscription_service)
    @add_subscription_command = Commands::AddSubscription.new(@subscription_service)
    @add_top_up_command = Commands::AddTopUp.new(@subscription_service)
    @print_renewal_details_command = Commands::PrintRenewalDetails.new(@renewal_service)
    @command_session = Commands::Session.new
  end

  def command_session
    @command_session.register_command(Commands::START_SUBSCRIPTION, @start_subscription_command)
    @command_session.register_command(Commands::ADD_SUBSCRIPTION, @add_subscription_command)
    @command_session.register_command(Commands::ADD_TOPUP, @add_top_up_command)
    @command_session.register_command(Commands::PRINT_RENEWAL_DETAILS, @print_renewal_details_command)
    @command_session
  end
end
