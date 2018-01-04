class Post < ActiveRecord::Base
  FACEBOOK = "facebook"
  INSTAGRAM = "instagram"
  
  validates :identifier, uniqueness: true
  
  scope :facebook_maximum, -> { where(social_media: FACEBOOK).maximum("original_created_time")}
  def self.get_channel_name(channel_url = "")
    channel_url.split("/").last if channel_url.present?
  end
end
