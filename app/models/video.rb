class Video < ActiveRecord::Base
  include Recentable

  HOSTS = {
    'youtube' => [/^.*(?:youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/,
                  'https://www.youtube.com/embed/#{code}'],
    'vimeo'   => [/\/\/(?:www\.)?vimeo.com\/(\d+)(?:$|\/|\?)/,
                  'https://player.vimeo.com/video/#{code}'],
  }.freeze
  HOSTS.each_value do |host_params|
    host_params.freeze
    host_params.each { |host_param| host_param.freeze }
  end

  attr_accessor :company_id

  validates :host, inclusion: { in: HOSTS.keys }, if: :url_changed?
  before_validation :adjust_url, if: :url_changed?

  belongs_to :category
  belongs_to :product
  belongs_to :user

  has_many :user_favourites, as: :favouriteable
  has_many :users, through: :user_favourites
  has_one :picture, as: :imageable

  accepts_nested_attributes_for :picture, allow_destroy: true

  def self.add_billet
    new main: false, day: false
  end

  def self.last_videos(except:, limit:)
    all.where.not(id: except.id).order(created_at: :desc).limit(limit)
  end

  private

  def url_changed?
    changed.include? 'url'
  end

  def adjust_url
    self.host, self.code = nil, nil

    HOSTS.each do |host, host_params|
      url_regexp, url_pattern = host_params
      if matchdata = url.match(url_regexp)

        self.host, self.code = host, matchdata[1]
        self.url = url_pattern.gsub '#{code}', code

        return
      end
    end

    nil
  end
end
