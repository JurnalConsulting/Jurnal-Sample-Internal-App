class Synchronize
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :jurnal_access_token, :response_body, :code, :type,
                :transaction_no,:deposit_account,:customer,:error_message

  APP_CLIENT_ID = ENV['APP_CLIENT_ID']
  JURNAL_ENDPOINT = ENV['JURNAL_BASE_PATH']
  
  def initialize(params={})
    @access_token = params[:jurnal_access_token]
    @type = params[:type]
    @transaction_no = params[:transaction_no]
    @deposit_account = params[:deposit_account]
    @customer = params[:customer]
  end

  def customer
    @customer
  end

  def transaction_no
    @transaction_no
  end

  def deposit_account
    @deposit_account.split(' - ')[1].strip
  end

  def type
    @type
  end

  def access_token
    @access_token
  end

  def get_items
    result = self.sync_to_jurnal
    if result
      self.response_body
    end
  end

  def get_company_deposit_account
    @type = "accounts"
    if get_items.present?
      deposit_account_collection = set_into_array_of_account_name(get_items.select{|v|v["category"]["name"]=="Cash & Bank"})
      return deposit_account_collection
    else return ['cant get items']
    end
  end

  def get_customers
    @type = "customers"
    if get_items.present?
      customers_collection = get_items.map{|v|v["display_name"]}
      return customers_collection
    else return ['cant get items']
    end
  end

  def add_sales_invoice
    @type = "sales_invoices"
    if add_sales_invoice_to_jurnal
      return true
    else return false
    end
  end

  def add_sales_invoice_to_jurnal
    require 'json'
    require 'net/http'
    require 'uri'
    url = "#{JURNAL_ENDPOINT}/partner/core/api/v1/#{type}?access_token=#{access_token}"
    encoded_url = URI.encode(url)
    uri = URI.parse(encoded_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.read_timeout = 600
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri,{'Content-Type' => 'application/json'})
    request.body = sales_invoice_body.to_json
    res = http.request(request)  
    data = JSON.parse(res.body)
    if res.code != "201"
      self.response_body = data
      self.code = res.code
      return false
    else
      self.response_body = data[type.singularize]
      self.code = res.code
      return true
    end
  end

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
    request = Net::HTTP::Post.new(uri.request_uri)
    res = http.request(request)  
    data = JSON.parse(res.body)
    if res.code != "200"
      self.response_body = data
      self.code = res.code
      return false
    else
      self.response_body = data[type]
      self.code = res.code
      raise
      return true
    end
  end
  
  def sync_to_jurnal
    require 'json'
    require 'net/http'
    require 'uri'
    url = "#{JURNAL_ENDPOINT}/partner/core/api/v1/#{type}?access_token=#{access_token}"
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
      self.response_body = data[type]
      self.code = res.code
      return true
    end
  end

  def set_into_array_of_account_name(array_of_hash)
    final_array = []
    array_of_hash.each do|hash|
      final_array << "(#{hash["number"]}) - #{hash["name"]} - (#{hash["category"]["name"]})"
    end
    final_array
  end

  private
  def sales_invoice_body
    {"sales_invoice"=>
        {"transaction_date"=>"2016-07-06",
          "tax_name"=>"",
          "due_date"=>"2016-07-06",
          "person_name"=>self.customer,
          "transaction_lines_attributes"=>
          [
            {
              "amount"=>1000,
              "quantity"=>1,
              "rate"=>1000,
              "discount"=>0,
              "tax"=>false,
              "product_name"=>"Sales"
            }
          ],
          "discount_unit"=>0,
          "discount_type_name"=>"Value",
          "deposit_to_name"=>self.deposit_account,
          "deposit"=>500,
          "transaction_no"=>self.transaction_no}}
  end
end