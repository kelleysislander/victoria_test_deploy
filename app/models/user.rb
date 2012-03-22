class User < ActiveRecord::Base
  
  has_many  :authentications
  has_many  :retailers, :through => :accounts  
  
  belongs_to  :account
  
  paginates_per 10 # kaminari pagination

  # validates_presence_of :account_id, :if => lambda{ |obj| obj.roles_mask > 1 } # regular users require an account_id, admin users do not
  validates_presence_of :account_id
  validates_presence_of :roles_mask, :message => "=> you must select at least one role for this user"
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  
  # devise :database_authenticatable, :token_authenticatable, :recoverable, :rememberable, :trackable, :validatable
  devise :database_authenticatable, :registerable, :token_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :roles_mask, :account_id, :roles

  scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0"} }

=begin
  "superadmin" can do everything such as create other users and create Accounts and create other admin users
  "admin" can do everything such as create other users and create Accounts
  "deal" can do everything with their Deals 
  "advertisement" can do everything with their Advertisements
  "retailer" can do everything with their Retailers
  "redemption" (outside users) can create redepmtions based on the account they belong to 
  "advertiser" can edit advertisers
  "traffic" can edit traffic_cameras and traffic_conditions
  "mobile" is the mobile device user who interacts via the methods in the api_controller
=end
  #               1       2     4       8            16        32        64       128    256
  ROLES = %w[superadmin admin deal advertisement retailer redemption advertiser traffic mobile]

  def set_roles_mask( role )
    self.roles_mask = 2**(ROLES.index( role ))
  end
  
  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

  def role? (role)
    roles.include? role.to_s
  end

  # used this way: current_user.has_role? ([:deal, :advertisement, :redemption, :admin])
  def has_role? (roles_array)
    roles_array.each do |role|
      if roles.include? role.to_s
        return true
      end
    end
    return false
  end
  
  def not_has_role? (roles_array)
    result = true
    roles_array.each do |role|
      if roles.include? role.to_s
        result = false
      end
    end
    result
  end
  
  def print_roles
    roles.map{ |r| r.humanize }.join(', ')
  end

  def ensure_authentication_token!
    reset_authentication_token! if self.authentication_token.blank?
  end
  
  def is_admin?
    role?('admin')
  end

  def is_deal?
    role?('deal')
  end
  
  def is_advertisement?
    role?('advertisement')
  end
  
  def is_redemption?
    role?('redemption')
  end
  
  def is_mobile?
    role?('mobile')
  end

  after_save :ensure_authentication_token!

end

=begin
Billys-MacBook-Pro ~/Projects/victoria: rake db:migrate
==  AddDeviseToUsers: migrating ===============================================
-- create_table(:users)
   -> 0.1594s
-- add_index(:users, :email, {:unique=>true})
   -> 0.2177s
-- add_index(:users, :reset_password_token, {:unique=>true})
   -> 0.1448s
==  AddDeviseToUsers: migrated (0.5223s) ======================================
=end