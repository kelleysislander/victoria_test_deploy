require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'time'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require *Rails.groups(:assets => %w(development test))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module Victoria
  class Application < Rails::Application

    # Sizes for the uploaded Advertisement graphics (width x height) => used in AdvertisementImageUploader
    # set as an array because that's how Carrierwave needs it
    SPLASH  = [310,446]
    FEAT    = [310,50]
    REG     = [310,50]
    # Size for the "Deal Badge" => used in DealsController#make_badge
    BADGE   = [75,75]
    # Size for the Deal image => used in DealImageUploader
    DEAL    = [110,110]
    DealDurationDisp = [100,67] # Green "days left" triangle in the upper right of the deal # Deal Image display size
    # Import size for the Deal image "duration_background.png"
    DealDuration    = [150,100]
    # Main deal image
    DealImage       = [110,110]
    DealTag         = [120,48]
    # Featured Deal image
    FeaturedDealImage   = [310,110]
    
    # Sizes for image display, used this way in the app: 
    # :size => "#{Victoria::Application::FEAT_INDEX}"
    # Deals
    BADGE_INDEX = "#{(0.6*BADGE[0]).to_i}x#{(0.6*BADGE[1]).to_i}"
    DealIndex  = "#{(0.6*DealImage[0]).to_i}x#{(0.6*DealImage[1]).to_i}"
    FeaturedDealIndex  = "#{(0.6*FeaturedDealImage[0]).to_i}x#{(0.6*FeaturedDealImage[1]).to_i}"
    # Advertisements
    SPLASH_INDEX  = "#{(SPLASH[0]/6).to_i}x#{(SPLASH[1]/6).to_i}"
    FEAT_INDEX    = "#{(FEAT[0]/4).to_i}x#{(FEAT[1]/4).to_i}"
    REG_INDEX     = "#{(REG[0]/4).to_i}x#{(REG[1]/4).to_i}" 
    
    GT_Coords = [14.624795, -90.532818] # Guatemala City, Guatemala
    RadiusDistance = 5
    
    # NOTE: You have to restart the server when changing any of these size variables
    
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    if Rails.env == "development" || Rails.env == "staging"
      config.time_zone = 'Central Time (US & Canada)'
    elsif Rails.env == "production"
      config.time_zone = 'Central Time (US & Canada)'
    end
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    # config.assets.version = '1.0'
    
    # NOTE: Added to make haml the default when using "nifty"scaffold"
    config.generators do |g|
      g.template_engine :haml
    end
    
  end
end
