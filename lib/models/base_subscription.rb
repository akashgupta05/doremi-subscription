class BaseSubscription
  attr_reader :price, :validity_in_months

  def initialize(price, validity_in_months)
    @price = price
    @validity_in_months = validity_in_months
  end
end
