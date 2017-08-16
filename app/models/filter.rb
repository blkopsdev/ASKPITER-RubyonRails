class Filter < ActiveRecord::Base
  has_many :filter_options
  belongs_to :sub_category

  accepts_nested_attributes_for :filter_options, allow_destroy: true
end
