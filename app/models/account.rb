class Account < ActiveRecord::Base
  
  has_many  :users
  has_many  :retailers
  has_many  :deals, :through => :retailers
  
  paginates_per 10 # kaminari pagination
  
  # attr_accessible :name, :description, :address, :city, :state, :phone, :contact_name, :contact_email, :created_at, :updated_at
          
  validates_presence_of :name, :address, :city, :state, :contact_name, :contact_email
  validates_uniqueness_of :name
  
  validates_length_of :name,    :within => 5..255,  :too_long => "Maximum size for 'Name' is 255.",     :too_short => "Minimum size for 'Name' is 5."
  validates_length_of :address, :within => 5..255,  :too_long => "Maximum size for 'Address' is 255.",  :too_short => "Minimum size for 'Address' is 5."
  validates_length_of :city,    :within => 5..255,  :too_long => "Maximum size for 'City' is 255.",     :too_short => "Minimum size for 'City' is 5."
  validates_length_of :state,   :within => 2..255,  :too_long => "Maximum size for 'Country' is 255.",     :too_short => "Minimum size for 'Country' is 2."
  # validates_length_of :zip,     :within => 5..10,   :too_long => "Maximum size for 'Zip' is 10.",       :too_short => "Minimum size for 'Name' is 5."
      
                                   
end                                    
                                       
                                       