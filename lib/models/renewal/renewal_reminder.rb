require_relative '../../constants/constants'
require_relative '../../enums/subscription_category'

class RenewalReminder
  attr_reader :renewal_date, :subscription_category

  def initialize(renewal_date, subscription_category)
    @renewal_date = renewal_date
    @subscription_category = subscription_category
  end

  def to_s
    category_name = SubscriptionCategory.const_get(subscription_category)
    "#{Constants::RENEWAL_REMINDER} #{category_name} #{renewal_date.strftime(Constants::DATE_FORMAT)}"
  end
end
