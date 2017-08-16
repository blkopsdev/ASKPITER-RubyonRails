class SubCategory < ActiveRecord::Base
  belongs_to :category
  has_many :products, inverse_of: :sub_category
  has_many :filters
  has_many :filter_options, through: :filters
  has_one :picture, as: :imageable
  has_many :companies, through: :products
  has_many :prices, through: :products

  accepts_nested_attributes_for :filters, allow_destroy: true
  accepts_nested_attributes_for :picture

  delegate :url, to: :picture, prefix: true, allow_nil: true # .picture_url
end
