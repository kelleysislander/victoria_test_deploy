class RedemptionPassphrasesController < ApplicationController
  
  before_filter :authenticate_user!

  authorize_resource
  
  layout 'admin'
  
  def index
    @redemption_passphrases = RedemptionPassphrase.order("end_date desc").page(params[:page])
    last_rec = RedemptionPassphrase.order("end_date desc").limit(1).first
    @last_id = last_rec.id if last_rec
  end

  def show
    @redemption_passphrase = RedemptionPassphrase.find(params[:id])
  end

  def new
    @redemption_passphrase = RedemptionPassphrase.new
    last_rec = RedemptionPassphrase.order("end_date desc").limit(1).first
    if last_rec
      @redemption_passphrase.beg_date = last_rec.end_date + 1
      @redemption_passphrase.end_date = last_rec.end_date + 1
    end
  end

  def create
    @redemption_passphrase = RedemptionPassphrase.new(params[:redemption_passphrase])
    if @redemption_passphrase.save
      redirect_to redemption_passphrases_path, :notice => "Successfully created Redemption Passphrase."
    else
      render :action => 'new'
    end
  end

  def edit
    @redemption_passphrase = RedemptionPassphrase.find(params[:id])
  end

  def update
    @redemption_passphrase = RedemptionPassphrase.find(params[:id])
    if @redemption_passphrase.update_attributes(params[:redemption_passphrase])
      redirect_to @redemption_passphrase, :notice  => "Successfully updated Redemption Passphrase."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @redemption_passphrase = RedemptionPassphrase.find(params[:id])
    @redemption_passphrase.destroy
    redirect_to redemption_passphrases_url, :notice => "Successfully destroyed redemption passphrase."
  end
end
