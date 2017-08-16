class Price < ActiveRecord::Base
  belongs_to :currency
  belongs_to :product

  def title
    options = {}
    options.merge! unit: currency.sign if currency && currency.sign.present?
    amount.to_s :currency, options
  end
end
