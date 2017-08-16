class POS < ActiveRecord::Base
  belongs_to :company
  belongs_to :distributor
end
