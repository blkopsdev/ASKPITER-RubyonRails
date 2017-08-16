class Picture < ActiveRecord::Base
  include Recentable

  belongs_to :imageable, polymorphic: true

  has_attached_file :image, styles: { :subcatcover => '1500x844#', thumbnail: '250x190>' }
  validates_attachment :image, presence: true, content_type: { content_type: /\Aimage\/.*\Z/ }

  delegate :url, to: :image
end
