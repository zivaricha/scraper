class Post < ActiveRecord::Base
  FACEBOOK = "facebook"
  INSTAGRAM = "instagram"
  
  validates :identifier, uniqueness: true
  
  scope :facebook_maximum, -> { where(social_media: FACEBOOK).maximum("original_created_time")}

end
