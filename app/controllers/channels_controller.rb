class ChannelsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def scan
    debugger
    puts 1
  end
end
