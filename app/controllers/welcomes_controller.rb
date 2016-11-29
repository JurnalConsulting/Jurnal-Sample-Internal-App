class WelcomesController < ApplicationController
  before_action :allow_iframe_requests
  skip_before_action :verify_authenticity_token
  
  def allow_iframe_requests
    response.headers.delete('X-Frame-Options')
  end

  def index
    @profile = Profile.new
  end

  def webhook_history_log
    @records = TableWebhookRecord.all.order(id: :desc)
  end

  def delete_webhook
    @webhook_user = WebhookUser.new(jurnal_access_token: params[:access_token])
    if @webhook_user.delete_webhook
      redirect_to profile_welcomes_path
    end
  end

  def push_to_webhook
    webhook_param = params[:notification]
    webhook_record = TableWebhookRecord.new

    webhook_record.topic = webhook_param[:object]
    webhook_record.content = webhook_param[:object_details]
    webhook_record.action =  webhook_param[:action]
    if webhook_record.save
      puts "berhasil"
      render json: {}, status: 200
    else
      puts "gagal"
      render json: {}, status: 422
    end
  end

  def profile
  end

  def create
    if profile_params[:username]=="jurnal"
      if profile_params[:password]=="123456"
        redirect_to profile_welcomes_path
      else
        set_new_init 
        render "index" and return
      end
    else 
      set_new_init
      render "index" and return
    end
  end

  def enable_webhook
    @webhook_user = WebhookUser.new(jurnal_access_token: params[:access_token])
    if !@webhook_user.get_webhook_id
      TableWebhookRecord.delete_all
      @webhook_user.create_webhook_id
    end
  end

  def sync_response
    synchronize = Synchronize.new({type: params[:type], jurnal_access_token: params[:access_token]})
    @items = synchronize.get_items
    @type = synchronize.type
  end

  def new_sales_invoice
    @new_invoice = Synchronize.new(jurnal_access_token: params[:access_token])
    @deposit_account_collection = @new_invoice.get_company_deposit_account
    @customers_collection = @new_invoice.get_customers
  end

  def create_sales_invoice
    @new_sales_invoice = Synchronize.new(params[:synchronize])
    if @new_sales_invoice.add_sales_invoice
      render "invoice_response" and return
    end
    render "invoice_response" and return
  end

  private
  
  def set_new_init
    @profile = Profile.new
    @profile.error_message = "username/password wrong."
  end

  def profile_params
    params[:profile]
  end
end
