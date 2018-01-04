class FacebookApi
  def self.get_channel_name(channel_url=nil)
    channel_url.split("/").last if channel_url.present?
  end
  
  def self.get_app_access_token
    oauth = Koala::Facebook::OAuth.new(ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'])
    oauth.get_app_access_token
  end
  
  def self.get_koala_graph_api_obj
    Koala::Facebook::API.new(get_app_access_token)
  end
end