class RedemptionsController < ApplicationController
  
  load_and_authorize_resource
  
  def index
    if current_user.has_role?([:redemption])
      # chained eager loading
      @redemptions = Redemption.where("#{current_user.account_id} = retailers.account_id").includes({:deal => { :retailer => {:account => {} }}}).order("deals.name, redemptions.created_at desc").page(params[:page])
    elsif current_user.has_role?([:admin,:superadmin])
      @redemptions = Redemption.includes({:deal => { :retailer => {:account => {} }}}).order("deals.name, redemptions.created_at desc").page(params[:page])
    else
      @redemptions = []
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @advertisement_types }
    end
  end
=begin
from ltc_new agent_controller:
  @commission_advances = CommissionAdvance.find( :all, 
    :include => [ {:application_policy_phase => { :applications => { :client => {}, :agent => {} }}}, :servicing_agent],
    :order => "Commission_Advances.Entry_Date" )
=end

  def show
    # @redemption = Redemption.find(params[:id])
  end

  def new
    # @redemption = Redemption.new
  end

  def create
    # @redemption = Redemption.new(params[:redemption])
    Deal.transaction do
      calc = Deal.calc_deals_num_attributes( params[:redemption]['deal_id'], params[:redemption]['num_redeemed'].to_i)
      if calc[:result] == true
        Deal.update_all( {:num_available => calc[:new_num_available], :num_redeemed => calc[:new_num_redeemed] }, ["id = ?", params[:redemption]['deal_id']] )
        @redemption.num_available = calc[:new_num_available]
        if @redemption.save
          redirect_to @redemption, :notice => "Redemption created. #{calc[:message]}\n"
        else
          render :action => 'new'
        end
      else
        redirect_to @redemption, :notice => "#{calc[:message]}\n"
        # render :action => 'new', :notice => calc[:message]
      end
    end # transaction
  end

  def edit
    # @redemption = Redemption.find(params[:id])
  end

  def update
    # @redemption = Redemption.find(params[:id])
    if @redemption.update_attributes(params[:redemption])
      redirect_to @redemption, :notice  => "Successfully updated redemption."
    else
      render :action => 'edit'
    end
  end

  def destroy
    # @redemption = Redemption.find(params[:id])
    @redemption.destroy
    redirect_to redemptions_url, :notice => "Successfully destroyed redemption."
  end
end
