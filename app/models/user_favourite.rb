class UserFavourite < ActiveRecord::Base

  belongs_to :user
  belongs_to :favouriteable, polymorphic: true

  validates :user, presence: true

  scope :categories, -> { where( favouriteable_type: 'Category' ) }
  scope :companies, -> { where( favouriteable_type: 'Company' ) }
  scope :products, -> { where( favouriteable_type: 'Product' ) }
  scope :user_products, -> (id) { where( favouriteable_type: 'Product', user_id: id) }
  scope :photos, -> { where( favouriteable_type: 'Photo' ) }
  scope :videos, -> { where( favouriteable_type: 'Video' ) }

  def self.get_favourites(user:, element:)
    where(user_id:user.id, favouriteable_type:element.class, favouriteable_id: element.id)
  end

  def self.in_favourites?(user:, element:)
    get_favourites(user:user, element:element).any?
  end

  def self.add_to_favourites(user:, element:)
    unless in_favourites?(user:user, element:element)
    create(user_id:user.id, favouriteable_type:element.class, favouriteable_id: element.id)
    end
  end

  def self.remove_from_favourites(user:, element:)
    get_favourites(user:user, element:element).destroy_all if in_favourites?(user:user, element:element)
  end

end
