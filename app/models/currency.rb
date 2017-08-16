class Currency < ActiveRecord::Base
  has_many :users
  has_many :prices
end
