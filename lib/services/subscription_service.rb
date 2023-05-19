require_relative '../models/factories/subscription_factory'
require_relative '../models/factories/device_factory'
require_relative '../enums/topup'
require_relative '../models/error/code'
require_relative '../models/error/message'
require 'date'

class SubscriptionService
  attr_reader :doremi_subscription

  def initialize(doremi_subscription)
    @doremi_subscription = doremi_subscription
  end

  def start_subscription(date_str)
    raise ErrorMessage::INVALID_DATE unless valid_date?(date_str)

    starting_date = Date.strptime(date_str, Constants::DATE_FORMAT)
    doremi_subscription.add_date_of_subscription(starting_date)
  end

  def add_subscription_for_user(subscription_category, subscription_plan)
    if doremi_subscription.subscription_status_pending?
      raise "#{ErrorCode::ADD_SUBSCRIPTION_FAILED} #{ErrorMessage::INVALID_DATE}"
    elsif doremi_subscription.subscription_category_exist?(subscription_category)
      raise "#{ErrorCode::ADD_SUBSCRIPTION_FAILED} #{ErrorMessage::DUPLICATE_CATEGORY}"
    end

    subscription = SubscriptionFactory.subscription(subscription_category, subscription_plan)
    doremi_subscription.add_subscription(subscription_category, subscription)
  end

  def add_top_up(type, no_of_months)
    if doremi_subscription.subscription_status_pending?
      raise "#{ErrorCode::ADD_TOPUP_FAILED} #{ErrorMessage::INVALID_DATE}"
    elsif doremi_subscription.subscription_status_started?
      raise "#{ErrorCode::ADD_TOPUP_FAILED} #{ErrorCode::SUBSCRIPTIONS_NOT_FOUND}"
    elsif doremi_subscription.top_up_status_added?
      raise "#{ErrorCode::ADD_TOPUP_FAILED} #{ErrorMessage::DUPLICATE_TOPUP}"
    end

    device_type = DeviceFactory.device(type)
    doremi_subscription.add_devices(device_type, no_of_months)
  end

  private

  def valid_date?(date_str)
    begin
      Date.strptime(date_str, Constants::DATE_FORMAT)
    rescue StandardError
      return false
    end
    true
  end
end
