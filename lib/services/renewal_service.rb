require_relative '../models/renewal/renewal_reminder'
require_relative '../models/renewal/renewal_amount'
require_relative '../enums/subscription_status'
require_relative '../enums/topup'
require_relative '../constants/constants'
require_relative '../models/error/code'

class RenewalService
  def initialize(doremi_subscription)
    @doremi_subscription = doremi_subscription
  end

  def calculate_renewal_dates
    raise ErrorCode::SUBSCRIPTIONS_NOT_FOUND if @doremi_subscription.subscription_status != SubscriptionStatus::ADDED

    renewal_reminders = []
    subscription_map = @doremi_subscription.subscription_map
    subscription_map.each do |subscription_category, subscription|
      renewal_reminders << RenewalReminder.new(renewal_date(subscription.validity_in_months), subscription_category)
    end
    renewal_reminders
  end

  def calculate_renewal_amount
    subscription_map = @doremi_subscription.subscription_map
    amount = subscription_map.values.sum(&:price).to_i
    amount += topup_amount

    RenewalAmount.new(amount.to_i)
  end

  private

  def topup_amount
    extra_devices = @doremi_subscription.device
    if @doremi_subscription.top_up_status == Topup::ADDED && !extra_devices.nil?
      return extra_devices.price * @doremi_subscription.no_of_months_for_top_up
    end

    Constants::ZERO
  end

  def renewal_date(validity)
    (@doremi_subscription.start_date >> validity) - Constants::NOTIFICATION_DAYS_BEFORE
  end
end
