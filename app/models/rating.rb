class Rating < ActiveRecord::Base

  DEFAULT_VALUE = 5

  belongs_to :product
  belongs_to :user
  belongs_to :review
  belongs_to :review, inverse_of: :rating

  validates :review, :value, presence: true

  before_save :set_product
  before_save :set_user

  def set_product
    self.product_id = review.product.id
  end

  def set_user
    self.user_id = review.user.id
  end

end
