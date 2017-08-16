class FilterOption < ActiveRecord::Base
  belongs_to :filter

  has_and_belongs_to_many :products
end
