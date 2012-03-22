class DealsController < ApplicationController
  
  before_filter :authenticate_user!

  load_and_authorize_resource
  
  def index
    if params[:preview] # for previewing deals in the "preview" state (link on menu "Preview Deals" sends in the param)
      if current_user.has_role?([:redemption])
        # chained eager loading of all deals in the "preview" state
        @deals = Deal.isapreview.where("#{current_user.account_id} = retailers.account_id").order('deals.beg_date desc, deals.name').includes( :advertiser, :redemptions, {:retailer => :account}).page(params[:page]) # .per(10) "paginates_per 10" is set in the model
      elsif current_user.has_role?([:admin,:superadmin,:deal]) # show all preview deals
        @deals = Deal.isapreview.order('beg_date desc, name').includes( :advertiser, :redemptions, {:retailer => :account}).page(params[:page]) # .per(10) "paginates_per 10" is set in the model
      end
    else # all deals that are not in "preview" state
      if current_user.has_role?([:redemption]) # show active, non-preview deals belonging to the current_user's account
        # chained eager loading
        @deals = Deal.notapreview.where("#{current_user.account_id} = retailers.account_id").order('deals.beg_date desc, deals.name').includes( :advertiser, :redemptions, {:retailer => :account}).page(params[:page]) # .per(10) "paginates_per 10" is set in the model
      elsif current_user.has_role?([:admin,:superadmin,:deal]) # show all non-preview deals
        @deals = Deal.notapreview.order('beg_date desc, name').includes( :advertiser, :redemptions, {:retailer => :account}).page(params[:page]) # .per(10) "paginates_per 10" is set in the model
      else
        @deals = []
      end
    end # if params[:preview]
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @deals }
    end
  end

  # GET /deals/1
  # GET /deals/1.json
  def show
    # @deal = Deal.find(params[:id], :include => [:retailer, :advertiser, {:retailer => :account}] )
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @deal }
    end
  end

  # GET /deals/new
  # GET /deals/new.json
  def new
    # @deal = Deal.new
    @deal.skeleton_flag = 1 # set up as a skeleton record
    @deal.preview_flag = 1 # set up as a preview
    @deal.featured_flag = 2 # start out as non-valid value as a placeholder
    @deal.name = "New_Preview_Deal_#{Time.now.to_f}"
    @deal.num_offered = 0
    # @deal.name = "New_Preview_Deal_#{Time.now.strftime("%m/%d/%Y - %I:%M:%S%P")}"
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @deal }
    end
  end

  # GET /deals/1/edit
  def edit
    # @deal = Deal.find(params[:id])
  end

  # POST /deals
  # POST /deals.json
  def create
    # @deal = Deal.new(params[:deal])
    respond_to do |format|
      if @deal.save
        # @deal.skeleton_flag = 0 # so the "Save" button appears at the bottom of the form after the create
        # badge = make_badge( @deal.badge_text.strip, @deal )
        @deal.update_attribute( :skeleton_flag, 0 ) # no longer a skeleton, which was just used to be able to conditionally validate in the model
        @deal.update_attribute( :preview_flag, 1 ) # if params[:commit] == "Preview"# mark as a "preview"
        format.html { redirect_to @deal, notice: "Deal was successfully created." }
        format.json { render json: @deal, status: :created, location: @deal }
      else
        format.html { render action: "new" }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /deals/1
  # PUT /deals/1.json
  def update
    # @deal = Deal.find(params[:id])
    respond_to do |format|
      # make_badge( params[:deal]['badge_text'].strip, @deal ) if params[:deal]['badge_text'].strip != @deal.badge_text.strip
      if @deal.update_attributes(params[:deal])
        @deal.update_attribute( :preview_flag, 0 ) if params[:commit] == "Save"# mark as no longer a "preview"
        @deal.update_attribute( :preview_flag, 1 ) if params[:commit] == "Preview"# mark as a "preview"
        if @deal.preview_flag == 0
          format.html { redirect_to @deal, notice: "Deal was successfully updated." }
          format.json { head :ok }
        else # in "preview" state, redirect to "edit"
          format.html { redirect_to edit_deal_path(@deal), notice: "Deal Preview successfully updated." }
          format.json { head :ok }
        end
      else
        format.html { render action: "edit" }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deals/1
  # DELETE /deals/1.json
  def destroy
    # @deal = Deal.find(params[:id])
    @deal.destroy
    respond_to do |format|
      format.html { redirect_to deals_url }
      format.json { head :ok }
    end
  end  
  
  # private
  
=begin
  in console:  
  dc = DealsController.new
    
  dc.make_badge("'$10 Off!'") 
  dc.make_badge("\'$ 10 Off\!\'") => $ 10 Off!
  dc.make_badge("'\$ billy'") $ billy
  dc.make_badge("'\\$billy") => $billy
  dc.make_badge("'\\$50.00") => $50.00 WORKS!!!
  reload! => between changes to the code here
  So we call it this way: "dc.make_badge("$10 Off!", @deal)"
=end    

  def make_badge( badge_text, deal )

    badge_text = badge_text.gsub('"', "").gsub("'", "").strip # take out single and double ticks
    badge_text = "'" << badge_text << "'" # enclose in single ticks
    badge_text = badge_text.gsub("$", "\\$").gsub("/", "") # take out forward and backslashes

    # img = MiniMagick::Image.open("public/images/yellow_starburst.jpg")
    img = MiniMagick::Image.open("app/assets/images/yellow_starburst.jpg")

    img.combine_options do |c|
      c.resize "#{Victoria::Application::BADGE[0]}x#{Victoria::Application::BADGE[1]}" # "75x75"
      c.gravity "Center"
      c.antialias
      c.font "helvetica italic"
      c.pointsize "18"
      c.draw "text 0,0 #{badge_text}"  # 0,0 = x,y coords
      c.fill("#000000")
    end
    # badge_path = "badges/badge_#{deal.id}.jpg"
    badge_path = "badge_#{deal.id}.jpg"
    deal.update_attribute(:badge_path, badge_path)
    # img.write("public/images/#{badge_path}")
    img.write("app/assets/badges/#{badge_path}")
    # returns "app/assets/images/badges/badge_21.jpg JPEG 145x150 145x150+0+0 8-bit DirectClass 11.6KB 0.000u 0:00.010 "
  end
  
  def make_duration_text
    # get number of days left for the deal
  end
  
end
=begin
NOTE: we took out the assets pipeline so now these comments are moot but kept here in case...
Billys-MacBook-Pro ~/Projects/victoria: rails c
Loading development environment (Rails 3.1.0)
>> puts Rails.application.config.assets.paths
/Users/billy/Projects/victoria/app/assets/badges
/Users/billy/Projects/victoria/app/assets/images
/Users/billy/Projects/victoria/app/assets/javascripts
/Users/billy/Projects/victoria/app/assets/stylesheets
/Users/billy/Projects/victoria/vendor/assets/stylesheets
/Users/billy/.rvm/gems/ruby-1.9.2-p290@victoria/gems/jquery-rails-1.0.16/vendor/assets/javascripts

img = MiniMagick::Image.from_file("jpeg.jpg")

img.combine_options do |c|
  c.gravity 'Southwest'
  c.draw 'text 10,10 "whatever"'
  c.font '-*-helvetica-*-r-*-*-18-*-*-*-*-*-*-2'
  c.fill("#FFFFFF")
end

img.write("new.jpg")

=end