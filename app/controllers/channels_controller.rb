class ChannelsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def scan
    debugger
    fb_channel_name = params[:fb].split("/").last if params[:fb].present?
    oauth_token = "EAACEdEose0cBABctxs6ZCx1D3GgFAd8RHzg1R5vjF4vxZAHIOQt4V8jvhgGwHanWf49sXx89HwJaS1A6aT4bRKkOrRfZBeeHaOAhY1PZAUF4o3weHqX7O6ciPgR4qCXXaXOq0mZBZBaW6KJ3HExNqBZALuqcABYZA6jDNSKKj7o9lhoUSLlOC0k0AbrzrTx9AJ9Scf3O7adaAAZDZD"
    begin
    client = Koala::Facebook::API.new(oauth_token)
    connection = client.get_connection(fb_channel_name, 'posts', {
      since: 1.months.ago.to_i,
      fields: ['message', 'id', 'from', 'type', 'picture', 'link', 'created_time', 'updated_time']
    })
    rescue Exception => e
      puts e.message
    end
    puts connection.first["id"] 
    connection2 = connection.next_page
    puts connection2.first["id"] 
    puts 1
  end
end
