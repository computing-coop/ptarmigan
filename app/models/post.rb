# -*- encoding : utf-8 -*-
class Post < ActiveRecord::Base
  paginates_per 7
  extend FriendlyId
  friendly_id :title, :use => :history
  has_and_belongs_to_many :postcategories
  belongs_to :user
  belongs_to :location
  belongs_to :subsite, optional: true
  has_many :podcasts

  has_attached_file :carousel, :styles =>  {:largest => "1600x712#",    :new_carousel => "1600x712#", :full => "960x427", :small => "320x143#", :thumb => "100x100>"},
                                            # :path =>  ":rails_root/public/images/carousel/posts/:id/:style/:normalized_resource_file_name",
                                            :url =>':s3_domain_url',
                                          path:  "carousel/posts/:id/:style/:normalized_resource_file_name", :default_url => "/assets/missing.png"

  has_attached_file :alternateimg, :styles => {:largest => "1200x500#",
                                          :full => "960x400#", :small => "300x200#",
                                          :thumb => "100x100>" },
                                          # :path =>  ":rails_root/public/images/posts/alt/:id/:style/:normalized_resource_file_name",
                                          :url =>':s3_domain_url',
                                          path:  "posts/alt/:id/:style/:normalized_resource_file_name", :default_url => "/assets/missing.png"

  translates :title, :body, fallbacks_for_empty_translations: true
  # attr_accessible :translations,  :remove_carousel, :embed_above_post, :second_embed_gallery_id, :embed_gallery_id, :subsite_id, :show_on_main, :user_id, :carousel, :not_news, :is_personal, :location_id, :translations_attributes, :hide_carousel, :published, :alternateimg, :sticky, :remove_alternateimg
  accepts_nested_attributes_for :translations, :reject_if => proc { |attributes| attributes['title'].blank? || attributes['body'].blank? }
  scope :by_location, -> (x) { where(['location_id = ? AND (subsite_id is null OR show_on_main is true)', x])}
  scope :by_subsite, -> (x) { where(:subsite_id => x) }
  scope :with_carousel, -> () { where(["hide_carousel is not true AND carousel_file_name is not null AND carousel_file_size > 0" ])}
  scope :not_news, -> () { where(not_news: true)}
  scope :news, -> () { where(not_news: false)}
  scope :published, -> () { where(published: true).order('published_at DESC')}
  scope :sticky, -> () { where(sticky: true)}
  validates_presence_of :location_id
  validates_attachment_content_type :alternateimg, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_attachment_content_type :carousel, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  attr_accessor :remove_carousel, :remove_alternateimg
  before_validation { carousel.clear if remove_carousel == '1' }
  before_validation { alternateimg.clear if remove_alternateimg == '1' }
  include PublicActivity::Model
  # tracked owner: ->(controller, model) { controller.current_user }
  Paperclip.interpolates :normalized_resource_file_name do |attachment, style|
    attachment.instance.normalized_resource_file_name
  end
  before_save :check_published
  before_save :extract_dimensions
  serialize :carousel_dimensions
  serialize :alternateimg_dimensions
  after_save :remove_blank_translations

  def carousel_image?
    carousel_content_type =~ %r{^(image|(x-)?application)/(bmp|gif|jpeg|jpg|pjpeg|png|x-png)$}
  end

  def alternateimg_image?
    alternateimg_content_type =~ %r{^(image|(x-)?application)/(bmp|gif|jpeg|jpg|pjpeg|png|x-png)$}
  end

  def remove_blank_translations
    translations.each{|x| x.destroy if  x.title.nil? && x.body.nil? }
  end

  def carousel_link
    self
  end


  def alternateimg_width
    if alternateimg?
      width, height = alternateimg_dimensions.split('x')
      return width.to_i
    else
      return 0
    end
  end

  def alternateimg_aspect?
    if alternateimg?
      width, height = alternateimg_dimensions.split('x')
      return (width.to_f / height.to_f ).to_f >= 1 ? :landscape : :portrait
    else
      return nil
    end
  end

  def carousel_date
    [created_at]
  end

  def check_published
    if self.published == true
      self.published_at ||= Time.now
    end
  end

  def description
    body
  end

  def embedded_images
    out = []
    if embed_gallery_id.blank? && second_embed_gallery_id.blank?
      out
    elsif !embed_gallery_id.blank? && second_embed_gallery_id.blank?
      out << Event.find(embed_gallery_id).flickers
    elsif !embed_gallery_id.blank? && !second_embed_gallery_id.blank?
      out << Event.find(embed_gallery_id).flickers
      out << Event.find(second_embed_gallery_id).flickers
    end
    if self.carousel?
      out.flatten.delete_if{|x| x.image.original_filename == self.carousel.original_filename }.flatten
    else
      out.flatten
    end
  end


  def rss_description(locale = :en)
    out = ""
    if carousel?
      out += ActionController::Base.helpers.image_tag("http://ptarmigan.fi" + carousel.url(:full))
    end
    out += "<p>posted #{I18n.l(feed_date.to_date, :format => :long)}"
    if subsite
      out += " in <a href=\"http://#{subsite.name}.ptarmigan.#{subsite.location.locale}\"/>#{subsite.name.humanize}</a>"
    end
    out += "</p>"
    out + body(locale)
    # body(locale)
  end

  def feed_date
    created_at
  end

  def icon
    carousel
  end

  def image
    carousel
  end



  def normalized_resource_file_name
    return false unless carousel_image?
    "#{self.id}-#{self.carousel_file_name.gsub( /[^a-zA-Z0-9_\.]/, '_')}"
  end
  def name
    title
  end


  def previous_post
    self.class.where("location_id = ? and published is true and published_at < ?", location_id, published_at).order("published_at desc").first
  end

  def next_post
    self.class.where("location_id = ? and published is true and published_at > ?", location_id, published_at).order("published_at asc").first
  end

  private

  # Retrieves dimensions for image assets
  # @note Do this after resize operations to account for auto-orientation.
  def extract_dimensions
    if carousel_image?
      tempfile = carousel.queued_for_write[:original]
      unless tempfile.nil?
        geometry = Paperclip::Geometry.from_file(tempfile)
        self.carousel_dimensions = [geometry.width.to_i, geometry.height.to_i].join('x')
      end
    end
    if alternateimg_image?
      atmp = alternateimg.queued_for_write[:original]
      unless atmp.nil?
        geometry = Paperclip::Geometry.from_file(atmp)
        self.alternateimg_dimensions = [geometry.width.to_i, geometry.height.to_i].join('x')
      end
    end
  end


end
