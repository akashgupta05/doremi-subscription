require_relative '../../constants/constants'

class RenewalAmount
  attr_reader :renewal_amount

  def initialize(renewal_amount)
    @renewal_amount = renewal_amount
  end

  def to_s
    "#{Constants::RENEWAL_AMOUNT} #{renewal_amount}"
  end
end
