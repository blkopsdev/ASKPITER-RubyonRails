class Search < ActiveRecord::Base
  belongs_to :user
  has_many :products

  scope :recent, -> {
    order( 'created_at DESC').take(10)
  }

end
