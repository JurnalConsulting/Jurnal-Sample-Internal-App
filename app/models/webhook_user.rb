class WebhookUser < ActiveRecord::Base

  attr_accessor :jurnal_access_token,:response_body,:code

  def initialize(params={})
    super
    @access_token = params[:jurnal_access_token]
  end

  def access_token
    @access_token
  end

  def get_webhook_response_id
    self.response_body["webhook_user_id"]
  end



  APP_CLIENT_ID = ENV['APP_CLIENT_ID']
  JURNAL_ENDPOINT = ENV['JURNAL_BASE_PATH']

  def get_webhook_id
    require 'json'
    require 'net/http'
    require 'uri'
    url = "#{JURNAL_ENDPOINT}/core/dev/oauth/webhooks?client_id=#{APP_CLIENT_ID}&access_token=#{access_token}"
    encoded_url = URI.encode(url)
    uri = URI.parse(encoded_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.read_timeout = 600
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri)
    res = http.request(request)  
    data = JSON.parse(res.body)
    if res.code != "200"
      self.response_body = data
      self.code = res.code
      return false
    else
      self.response_body = data
      self.code = res.code
      return true
    end
  end

  def delete_webhook
    require 'json'
    require 'net/http'
    require 'uri'
    TableWebhookRecord.delete_all
    url = "#{JURNAL_ENDPOINT}/core/dev/oauth/webhooks?client_id=#{APP_CLIENT_ID}&access_token=#{access_token}"
    encoded_url = URI.encode(url)
    uri = URI.parse(encoded_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.read_timeout = 600
    http.use_ssl = true
    request = Net::HTTP::Delete.new(uri.request_uri)
    res = http.request(request)  
    if res.code != "204"
      self.code = res.code
      return false
    else
      self.code = res.code
      return true
    end
  end

  def create_webhook_id
    require 'json'
    require 'net/http'
    require 'uri'
    url = "#{JURNAL_ENDPOINT}/core/dev/oauth/webhooks?client_id=#{APP_CLIENT_ID}&access_token=#{access_token}"
    encoded_url = URI.encode(url)
    uri = URI.parse(encoded_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.read_timeout = 600
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri)
    res = http.request(request)  
    data = JSON.parse(res.body)
    if res.code != "200"
      self.response_body = data
      self.code = res.code
      return false
    else
      self.response_body = data
      self.code = res.code
      return true
    end
  end

end