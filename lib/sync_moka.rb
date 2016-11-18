class SyncMoka
  
  def self.get_access_token(code)
    client_id = "69bacebb2acf05ab957ad69ac683503b82c5faf5c445dc993c6a6035e3a8b228"
    callback_url = "http://localhost:4000"
    secret_key = "384c37a3b88fe809e4af69f61fd86265faa98669727eb47bec3225e7e2d04776"

    require "net/http"
    require "uri"

    url = "https://api.mokapos.com/oauth/token?client_id=#{client_id}&code=#{code}&client_secret=#{secret_key}&redirect_uri=#{callback_url}&grant_type=authorization_code"
    encoded_url = URI.encode(url)
    uri = URI.parse(encoded_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new(uri.request_uri)
    Rails.logger.info("request: #{request.body}")
    response = http.request(request)
    Rails.logger.info("response: #{response.body}")
    json = JSON.parse(response.body)
    json
    raise
  end

end