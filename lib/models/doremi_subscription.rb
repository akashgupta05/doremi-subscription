require_relative '../enums/subscription_status'
require_relative '../enums/topup'

class DoremiSubscription
  attr_accessor :start_date, :subscription_map, :subscription_status, :top_up_status,
                :no_of_months_for_top_up, :device

  def initialize
    @start_date = nil
    @subscription_map = {}
    @subscription_status = SubscriptionStatus::PENDING
    @top_up_status = Topup::EMPTY
    @no_of_months_for_top_up = 0
    @device = nil
  end

  def add_date_of_subscription(date_of_subscription)
    @start_date = date_of_subscription
    @subscription_status = SubscriptionStatus::STARTED
  end

  def add_subscription(subscription_category_type, subscription)
    @subscription_status = SubscriptionStatus::ADDED
    @subscription_map[subscription_category_type] = subscription
  end

  def subscription_category_exist?(subscription_category)
    @subscription_map.key?(subscription_category)
  end

  def add_devices(device, no_of_months)
    @top_up_status = Topup::ADDED
    @no_of_months_for_top_up = no_of_months
    @device = device
  end

  def subscription_status_pending?
    @subscription_status == SubscriptionStatus::PENDING
  end

  def subscription_status_started?
    @subscription_status == SubscriptionStatus::STARTED
  end

  def subscription_status_added?
    @subscription_status == SubscriptionStatus::ADDED
  end

  def top_up_status_added?
    @top_up_status == Topup::ADDED
  end
end
