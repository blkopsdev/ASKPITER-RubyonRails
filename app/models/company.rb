class Company < ActiveRecord::Base
  has_many :products
  has_many :pos, class_name: 'POS'
  has_many :distributors, through: :pos
  
  has_one :address, as: :addressable

  has_many :sub_categories, through: :products
  has_many :categories, through: :sub_categories

  has_many :user_favourites, as: :favouriteable
  has_many :users, through: :user_favourites

  accepts_nested_attributes_for :address


  def self.local(country_code)
    country_code ? joins(:address).where(addresses: { country_code: country_code }).uniq : none
  end

  def self.international(country_code)
    where(id:(all - local(country_code)).map(&:id))
  end

  def self.with_sub_categories(sub_categories_ids)
    sub_categories_ids ||= []
    if sub_categories_ids.any?
      joins(:products).where(products: { sub_category_id: sub_categories_ids.map(&:to_i) }).uniq
    else
      all
    end
  end

end
