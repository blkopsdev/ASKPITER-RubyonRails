class User < ActiveRecord::Base
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :currency
  belongs_to :language
  has_one :address, as: :addressable, dependent: :destroy
  has_many :ratings
  
  has_many :favourites, foreign_key: 'user_id', class_name: 'UserFavourite', dependent: :destroy

  has_many :user_favourite_categories, -> { UserFavourite.categories }, class_name: 'UserFavourite'
  has_many :favourite_categories, through: :user_favourite_categories, source: :favouriteable, source_type: 'Category'

  has_many :user_favourite_companies, -> { UserFavourite.companies }, class_name: 'UserFavourite'
  has_many :favourite_companies, through: :user_favourite_companies, source: :favouriteable, source_type: 'Company'

  has_many :user_favourite_photos, -> { UserFavourite.photos }, class_name: 'UserFavourite'
  has_many :favourite_photos, through: :user_favourite_photos, source: :favouriteable, source_type: 'Photo'

  has_many :user_favourite_products, -> { UserFavourite.products }, class_name: 'UserFavourite'
  has_many :favourite_products, through: :user_favourite_products, source: :favouriteable, source_type: 'Product'

  has_many :user_favourite_videos, -> { UserFavourite.videos }, class_name: 'UserFavourite'
  has_many :favourite_videos, through: :user_favourite_videos, source: :favouriteable, source_type: 'Video'

  has_many :videos
  has_many :photos

  has_many :reviews
  has_many :searches
  has_one :picture, as: :imageable, dependent: :destroy

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :picture

  def save_search( search_string )
    if ( searches.last.nil? or searches.last.text != search_string ) and !search_string.blank?
      searches.build( text: search_string )
      save
    end
  end

  def remove_search( id )
    s = searches.find_by_id(id)
    searches.delete( s ) if s
  end

end
