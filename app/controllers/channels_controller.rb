class ChannelsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def scan
    fb_channel_name = params[:fb].split("/").last if params[:fb].present?
    oauth = Koala::Facebook::OAuth.new(ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'])
    app_access_token = oauth.get_app_access_token 
    debugger
    begin
      client = Koala::Facebook::API.new(app_access_token)
      if fb_channel_name.present?
        posts = client.get_connection(fb_channel_name, 'posts', {
          since: 1.months.ago.to_i,
          fields: ['message', 'id', 'picture', 'link', 'created_time']
        })
        debugger
        render :json => "fb channel has no posts from the past month" if posts.size == 0
        
        max_original_created_time = Post.facebook_maximum
        reached_existing_post = false
        debugger
        while posts.size > 0
          posts.each do |post|
            if max_original_created_time.present? && post["created_time"] <= max_original_created_time
              reached_existing_post = true
              break 
            end
            post_id = post["id"].split("_").last
            @post = Post.new(identifier: post_id, caption: post["message"], attachment_url: post["picture"],
                              original_created_time: post["created_time"], social_media: "facebook")
            if @post.save
              puts "post #{@post.identifier} was saved succefully"
            else
              puts "this error prevented from being saved #{@post.errors.full_messages}"
            end
          end
          break if reached_existing_post
          posts = posts.next_page
        end
      else
        render :json => "fb channel name is invalid #{params[:fb]}"
      end
    rescue Exception => e
      puts e.message
    end
    
  end
  
  def get_access_token
    debugger
    puts 1
  end
end
