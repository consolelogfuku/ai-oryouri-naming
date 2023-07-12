class ApplicationController < ActionController::Base
  require 'openai'
  require 'dotenv'
  Dotenv.load

  before_action :set_common_variable

  private

  def set_common_variable
    client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])
  end
end
