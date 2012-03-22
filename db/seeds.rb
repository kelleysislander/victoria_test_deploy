# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create the first 'Admin' user

# require 'map'

tables = [
  'accounts',
  'users', 
  'retailers',
  'retailer_categories',
  'advertisers',
  'advertiser_types',
  'deals', 
  'deal_types',
  'advertisements', 
  'advertisement_types',
  'redemptions',
  'traffic_conditions',
  'traffic_condition_historicals',
  'redemption_passphrases' ]
disp_tables = []
tables.map! { |table| ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table};"); disp_tables << table }

puts "Tables #{disp_tables} Truncated"

# Redemption Passphrases

RedemptionPassphrase.create!( :passphrase => "Absence makes the heart grow fonder",       :beg_date   =>  '2012-02-28', :end_date   =>  '2012-03-01' )
RedemptionPassphrase.create!( :passphrase => "Beauty is only skin deep",                  :beg_date   =>  '2012-03-02', :end_date   =>  '2012-03-05' )
RedemptionPassphrase.create!( :passphrase => "Clear moon, frost soon.",                   :beg_date   =>  '2012-03-06', :end_date   =>  '2012-03-07' )
RedemptionPassphrase.create!( :passphrase => "Discretion is the better part of valour",   :beg_date   =>  '2012-03-08', :end_date   =>  '2012-03-12' )
RedemptionPassphrase.create!( :passphrase => "Easy come, easy go",                        :beg_date   =>  '2012-03-13', :end_date   =>  '2012-03-17' )
RedemptionPassphrase.create!( :passphrase => "First things first",                        :beg_date   =>  '2012-03-18', :end_date   =>  '2012-03-21' )
RedemptionPassphrase.create!( :passphrase => "Great minds think alike",                   :beg_date   =>  '2012-03-22', :end_date   =>  '2012-03-31' )
RedemptionPassphrase.create!( :passphrase => "Half a loaf is better than none",           :beg_date   =>  '2012-04-01', :end_date   =>  '2012-04-03' )
RedemptionPassphrase.create!( :passphrase => "It is always darkest before the dawn",      :beg_date   =>  '2012-04-04', :end_date   =>  '2012-04-07' )
RedemptionPassphrase.create!( :passphrase => "Justice delayed is justice denied",         :beg_date   =>  '2012-04-08', :end_date   =>  '2012-04-10' )
RedemptionPassphrase.create!( :passphrase => "Knowledge is power",                        :beg_date   =>  '2012-04-11', :end_date   =>  '2012-04-13' )
RedemptionPassphrase.create!( :passphrase => "Laughter is the best medicine",             :beg_date   =>  '2012-04-14', :end_date   =>  '2012-04-18' )
RedemptionPassphrase.create!( :passphrase => "Many hands make light work",                :beg_date   =>  '2012-04-19', :end_date   =>  '2012-04-22' )
RedemptionPassphrase.create!( :passphrase => "No news is good news",                      :beg_date   =>  '2012-04-23', :end_date   =>  '2012-04-23' )
RedemptionPassphrase.create!( :passphrase => "One man's trash is another man's treasure", :beg_date   =>  '2012-04-24', :end_date   =>  '2012-04-27' )
RedemptionPassphrase.create!( :passphrase => "Penny wise, pound foolish",                 :beg_date   =>  '2012-04-28', :end_date   =>  '2012-04-30' )

Account.create!( 
  :name           => "Victoria Admin Account",
  :address        => "1301 Hwy 191",
  :city           => "Richardson",
  :state          => "TX",
  :zip            => "75080",
  :phone          => "(555) 555-5555",
  :contact_name   => "Jose Guzman",
  :contact_email  => "jose.guzman@victoria.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now )

Account.create!( 
  :name           => "Kohl's Department Stores",
  :address        => "4A Avenida, Zona 1",
  :city           => "Ciudad de Guatemala",
  :state          => "Guatemala",
  :phone          => "(262) 703-7000",
  :contact_name   => "Sherry Johnson",
  :contact_email  => "sherry.johnsom@kohlscorp.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now )

Account.create!( 
  :name           => "Radio Shack Stores",
  :address        => "9na. Calle 'A' 3-20 Zona 1",
  :city           => "Ciudad de Guatemala",
  :state          => "Guatemala",
  :phone          => "(817) 415-3011",
  :contact_name   => "Alex Abernathy Johnson",
  :contact_email  => "alex.abernathy@radioshack.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now )
  
Account.create!(
  :name           => "Sears Stores LLC",
  :address        => "Km.14.5 Carr. El Salvador C.C. Escala L.#30",
  :city           => "Guatemala City",
  :state          => "Guatemala",
  :phone          => "(817) 415-3011",
  :contact_name   => "George Sears",
  :contact_email  => "george.sears@sears.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now )

# Darlene's Boutique & Billy's Heli Shop parent
Account.create!(
  :name           => "BKDK LLC",
  :address        => "Via 5 4-68 Zona 4",
  :city           => "Guatemala City",
  :state          => "Guatemala",
  :phone          => "(817) 415-3011",
  :contact_name   => "Bill Kiskin",
  :contact_email  => "bill.k@sbcglobal.net",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now )

Account.create!(
  :name           => "Half Price Books Stores LLC",
  :address        => "Manzana K Casa 7 Residenciales Villas Alameda Zona 18",
  :city           => "Ciudad de Guatemala",
  :state          => "Guatemala",
  :zip            => "75232",
  :phone          => "555-555-1212",
  :contact_name   => "Gordon Alexander",
  :contact_email  => "gordy.al@hpbooks.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now )
  
# Kristian's Scuba King parent
Account.create!(
  :name           => "HoJoLeLa LLC",
  :address        => "Ruta 3 Via 5 esquina Zona 4",
  :city           => "Ciudad de Guatemala",
  :state          => "Guatemala",
  :phone          => "555-555-1212",
  :contact_name   => "Kristian Takvham",
  :contact_email  => "kt@scubaking.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now )

Account.create!(
  :name           => "Walgreen's Stores LLC",
  :address        => "Bulevar Vista Hermosa 17-30 Plaza Nahum oficina 102 Zona 15",
  :city           => "Ciudad de Guatemala",
  :state          => "Guatemala",
  :phone          => "206-266-1000",
  :contact_name   => "Samuel Walton",
  :contact_email  => "samuel.walton@walgreens.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now )

Account.create!(
  :name           => "Home Depot Stores",
  :address        => "1ra. Calle 37-11 Colonia Toledo Zona 11",
  :city           => "Ciudad de Guatemala",
  :state          => "Guatemala",
  :phone          => "(800)-466-3337",
  :contact_name   => "Homer Mills Depot",
  :contact_email  => "homer.depot@homedepot.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now )

Account.create!(
  :name           => "Herb's Paint and Body Shops LLC",
  :address        => "12 Calle, Zona 11",
  :city           => "Guatemala City",
  :state          => "Guatemala",
  :phone          => "(214) 328-4381",
  :contact_name   => "Herbie Hancock",
  :contact_email  => "herbie.hancock@herbs.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now )

Account.create!(
  :name           => "Fry's Electronics Stores LLC",
  :address        => "Av. Reforma 13-70 Zona 9 Edificio Real Reforma - Primer Nivel",
  :city           => "Ciudad de Guatemala",
  :state          => "Guatemala",
  :phone          => "(408) 487-4500",
  :contact_name   => "Chester Fry",
  :contact_email  => "chester.fried@outpost.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now )

Account.create!(
  :name           => "Mobile Users Account",
  :address        => "...na...",
  :city           => "...na...",
  :state          => "na",
  :zip            => "12345",
  :phone          => "555-555-1212",
  :contact_name   => "...na...",
  :contact_email  => "...na...",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now )

puts "Accounts created"

=begin
#                 1       2     4       8            16        32        64        128   256
# ROLES = %w[superadmin admin deal advertisement retailer redemption advertiser traffic mobile]
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

# NOTE:  We have to update the attribute "account_id" afterwards because it will not be getting set, probably due to some Devise interaction
# Super Admin (Victoria) user
user = User.create!( 
  :account_id             => nil,
  :name                   => "Superadmin User (Victoria)",         
  :email                  => "superadmin@miinfo.com.gt", 
  :password               => "please", 
  :password_confirmation  => "please",
  :account_id             => 0,
  :roles_mask             => 0)
user.account_id = Account.where(:name => "Victoria Admin Account").first.id; user.save!
# Admin (Victoria) user
user = User.create!( 
  :account_id             => nil,
  :name                   => "Admin User (Victoria)",         
  :email                  => "admin@miinfo.com.gt", 
  :password               => "please", 
  :password_confirmation  => "please",
  :account_id             => 0,
  :roles_mask             => 0)
user.account_id = Account.where(:name => "Victoria Admin Account").first.id; user.save!

# Deal (Victoria) user
user = User.create!( 
  :account_id             => nil,
  :name                   => "Deal User (Victoria)",         
  :email                  => "deal@miinfo.com.gt", 
  :password               => "please", 
  :password_confirmation  => "please",
  :account_id             => 0,
  :roles_mask             => 0)
user.account_id = Account.where(:name => "Victoria Admin Account").first.id; user.save!
# Advertisement (Victoria) user
user = User.create!( 
  :account_id             => nil,
  :name                   => "Advertisement User (Victoria)",
  :email                  => "advertisement@miinfo.com.gt",
  :password               => "please", 
  :password_confirmation  => "please",
  :account_id             => 0,
  :roles_mask             => 0)
user.account_id = Account.where(:name => "Victoria Admin Account").first.id; user.save!
# Retailer (Victoria) user
user = User.create!( 
  :account_id             => nil,
  :name                   => "Retailer User (Victoria)",         
  :email                  => "retailer@miinfo.com.gt", 
  :password               => "please", 
  :password_confirmation  => "please",
  :account_id             => 0,
  :roles_mask             => 0)
user.account_id = Account.where(:name => "Victoria Admin Account").first.id; user.save!
# Advertiser (Victoria) user
user = User.create!( 
  :account_id             => nil,
  :name                   => "Advertiser User (Victoria)",         
  :email                  => "advertiser@miinfo.com.gt", 
  :password               => "please", 
  :password_confirmation  => "please",
  :account_id             => 0,
  :roles_mask             => 0)
user.account_id = Account.where(:name => "Victoria Admin Account").first.id; user.save!
# Traffic (Victoria) user #1
user = User.create!( 
  :account_id             => nil,
  :name                   => "Traffic User 1 (Victoria)",         
  :email                  => "traffic1@miinfo.com.gt", 
  :password               => "please", 
  :password_confirmation  => "please",
  :account_id             => 0,
  :roles_mask             => 0)
user.account_id = Account.where(:name => "Victoria Admin Account").first.id; user.save!
# Traffic (Victoria) user #2
user = User.create!( 
  :account_id             => nil,
  :name                   => "Traffic User 2 (Victoria)",         
  :email                  => "traffic2@miinfo.com.gt", 
  :password               => "please", 
  :password_confirmation  => "please",
  :account_id             => 0,
  :roles_mask             => 0)
user.account_id = Account.where(:name => "Victoria Admin Account").first.id; user.save!
# Mobile user

# ********************************************************************************************************

# Redemption Users for the various Retailers:
# Kohl's Account redemption user
user = User.create!( 
  :name                   => "Kohl's User",         
  :email                  => "kohlsredemption@kohls.com", 
  :password               => "please", 
  :password_confirmation  => "please",
  :account_id             => 0,
  :roles_mask             => 0)
user.account_id = Account.where(:name => "Kohl's Department Stores").first.id; user.save!
# Radio Shack Account redemption user
user = User.create!( 
  :name                   => "Radio Shack User",         
  :email                  => "radioshackredemption@radioshack.com", 
  :password               => "please", 
  :password_confirmation  => "please",
  :account_id             => 0,
  :roles_mask             => 0)
user.account_id = Account.where(:name => "Radio Shack Stores").first.id; user.save!
# Sears Account redemption user
user = User.create!( 
  :name                   => "Sears User",         
  :email                  => "searsredemption@sears.com", 
  :password               => "please", 
  :password_confirmation  => "please",
  :account_id             => 0,
  :roles_mask             => 0)
user.account_id = Account.where(:name => "Sears Stores LLC").first.id; user.save!
# BKDK Account redemption user #1
user = User.create!( 
  :name                   => "BKDK User #1",  
  :email                  => "bkdk1redemption@sbcglobal.net",     
  :password               => "please", 
  :password_confirmation  => "please",
  :account_id             => 0,
  :roles_mask             => 0)
user.account_id = Account.where(:name => "BKDK LLC").first.id; user.save!
# BKDK Account redemption user #2
user = User.create!( 
  :name                   => "BKDK User #2",  
  :email                  => "bkdk2redemption@sbcglobal.net",     
  :password               => "please", 
  :password_confirmation  => "please",
  :account_id             => 0,
  :roles_mask             => 0)
user.account_id = Account.where(:name => "BKDK LLC").first.id; user.save!
# Half Price Books Account redemption user
user = User.create!( 
  :name                   => "Half Price Books User",  
  :email                  => "hpbooksredemption@hpbooks.com",     
  :password               => "please", 
  :password_confirmation  => "please",
  :account_id             => 0,
  :roles_mask             => 0)
user.account_id = Account.where(:name => "Half Price Books Stores LLC").first.id; user.save!
# HoJoLeLa (Kristian's Scuba King) Account redemption user
user = User.create!( 
  :name                   => "HoJoLeLa User",  
  :email                  => "scubakingredemption@scubaking.com",     
  :password               => "please", 
  :password_confirmation  => "please",
  :account_id             => 0,
  :roles_mask             => 0)
user.account_id = Account.where(:name => "HoJoLeLa LLC").first.id; user.save!
# Walgreen's Account redemption user
user = User.create!( 
  :name                   => "Walgreen's User",  
  :email                  => "walgreensredemptionr@walgreens.com",     
  :password               => "please", 
  :password_confirmation  => "please",
  :account_id             => 0,
  :roles_mask             => 0)
user.account_id = Account.where(:name => "Walgreen's Stores LLC").first.id; user.save!
# Home Depot Account redemption user
user = User.create!( 
  :name                   => "Home Depot User",  
  :email                  => "homedepotredemption@homedepot.com",     
  :password               => "please", 
  :password_confirmation  => "please",
  :account_id             => 0,
  :roles_mask             => 0)
user.account_id = Account.where(:name => "Home Depot Stores").first.id; user.save!
# Herb's Account redemption user
user = User.create!( 
  :name                   => "Herb's User",  
  :email                  => "herbsredemption@herbspaintandbody.com",     
  :password               => "please", 
  :password_confirmation  => "please",
  :account_id             => 0,
  :roles_mask             => 0)
user.account_id = Account.where(:name => "Herb's Paint and Body Shops LLC").first.id; user.save!
# Fry's Account redemption user
user = User.create!( 
  :name                   => "Fry's User",  
  :email                  => "frysredemption@outpost.com",     
  :password               => "please", 
  :password_confirmation  => "please",
  :account_id             => 0,
  :roles_mask             => 0)
user.account_id = Account.where(:name => "Fry's Electronics Stores LLC").first.id; user.save!
# Mobile user
user = User.create!( 
  :name                   => "Mobile User",  
  :email                  => "mobile@miinfo.com.gt",     
  :password               => "please", 
  :password_confirmation  => "please",
  :account_id             => 0,
  :roles_mask             => 0)
user.account_id = Account.where(:name => "Mobile Users Account").first.id; user.save!

puts "Users created"
#                 1       2     4       8            16        32        64        128
# ROLES = %w[superadmin admin deal advertisement retailer redemption advertiser traffic]

# NOTE:  this last statements do not set the value of roles_mask so after the users are created we update:
# Update everybody to be a redemption user
User.update_all( :roles_mask => 32) # redemption user
# Then update the SuperAdmin
user = User.where(:email => "superadmin@miinfo.com.gt").first
user.update_attribute( :roles_mask, 1) # superadmin
# user.save
# Then the Admin users
user = User.where(:email => "admin@miinfo.com.gt").first
user.update_attribute( :roles_mask, 2) # admin
# user.save
# Then the Deal user
user = User.where(:email => "deal@miinfo.com.gt").first
user.update_attribute( :roles_mask, 4) # deal
# user.save
#  and the Advertisement user
user = User.where(:email => "advertisement@miinfo.com.gt").first
user.update_attribute( :roles_mask, 8) # advertisement
# user.save
#  and the Retailer user
user = User.where(:email => "retailer@miinfo.com.gt").first
user.update_attribute( :roles_mask, 16) # retailer
#  and the Retailer user
user = User.where(:email => "advertiser@miinfo.com.gt").first
user.update_attribute( :roles_mask, 64) # retailer
# and the Traffic user #1
user = User.where(:email => "traffic1@miinfo.com.gt").first
user.update_attribute( :roles_mask, 128) # traffic
# and the Traffic user #2
user = User.where(:email => "traffic2@miinfo.com.gt").first
user.update_attribute( :roles_mask, 128) # traffic
# mobile user
user = User.where(:email => "mobile@miinfo.com.gt").first
user.update_attribute( :roles_mask, 256) # mobile

puts "Users' roles_mask updated"

# miinfo categories
=begin
All offers – Todas las Ofertas
Food and more - Comida y mas
Entertainment - Entretenimiento
Health and Beauty- Salud y Belleza
Services - Servicios
Kids- Niños
Real Estate- Bienes Raíces
Automotive - Autos
=end
RetailerCategory.create!(
  :retailer_category => "All offers - Todas las Ofertas",
  :description => "All offers - Todas las Ofertas")
RetailerCategory.create!(
  :retailer_category => "Food and more - Comida y mas",
  :description => "Food and more - Comida y mas")
RetailerCategory.create!(
  :retailer_category => "Entertainment - Entretenimiento",
  :description => "Entertainment - Entretenimiento")
RetailerCategory.create!(
  :retailer_category => "Health and Beauty- Salud y Belleza",
  :description => "Health and Beauty- Salud y Belleza")
RetailerCategory.create!(
  :retailer_category => "Services - Servicios",
  :description => "Services - Servicios")
RetailerCategory.create!(
  :retailer_category => "Kids- Ninos",
  :description => "Kids- Ninos")
RetailerCategory.create!(
  :retailer_category => "Real Estate- Bienes Raices",
  :description => "Real Estate - Bienes Raices")
RetailerCategory.create!(
  :retailer_category => "Automotive - Autos",
  :description => "Automotive - Autos")

puts "Retailer Categories created"

=begin
Guatemala Addresses
Ciudad de Guatemala, Guatemala: Latitude: 14.624795, -90.532818
Map Zone 1
  Zona 1
    4A Avenida, Zona 1, Ciudad de Guatemala, Guatemala
    9na. Calle "A" 3-20 Zona 1, Ciudad de Guatemala, Guatemala
    Tua Restaurant: Km.14.5 Carr. El Salvador C.C. Escala L.#30, Guatemala City, Guatemala
    Cafe La Paix: Via 5 4-68 Zona 4, Guatemala City, Guatemala 
  Zona 3:
    7A Avenida Zona 3 Ciudad de Guatemala, Guatemala
    Km 6 5 Carretera Al Atlantico, Guatemala City, Guatemala
    14 Calle, Zona 3, Guatemala City, Guatemala
  Zona 10:
    BAD: 6a. Avenida 8-71, Zona 10 Zona 10, Ciudad de Guatemala, Guatemala
Map Zone 2:
  Zona 2:
    8 Calle 3-67 Zona 10, Guatemala City, Guatemala
Map Zone 3:
  Zona 18:
    Manzana K Casa 7 Residenciales Villas Alameda Zona 18, Ciudad de Guatemala, Guatemala
  Zona 4:
    Ruta 3 Via 5 esquina Zona 4, Ciudad de Guatemala, Guatemala
  Zona 15:
    Bulevar Vista Hermosa 17-30 Plaza Nahum oficina 102 Zona 15, Ciudad de Guatemala, Guatemala
  Zona 11:
    1ra. Calle 37-11 Colonia Toledo Zona 11, Ciudad de Guatemala, Guatemala
    12 Calle, Zona 11 Guatemala City, Guatemala (Friday's)
  Zona 9:
    Av. Reforma 13-70 Zona 9 Edificio Real Reforma - Primer Nivel Ciudad de Guatemala, Ciudad de Guatemala, Guatemala
  
20 Calle 10-17 Aurora II Zona 13, Ciudad de Guatemala, Guatemala
Bulevar Vista Hermosa 17-30 Plaza Nahum oficina 102 Zona 15, Ciudad de Guatemala, Guatemala
Av. Reforma 13-70 Zona 9 Edificio Real Reforma - Primer Nivel Ciudad de Guatemala, Ciudad de Guatemala, Guatemala
17 Avenida 3-21 Colonia Miraflores a media cuadra de Bolevard Roosevelt Zona 11, Ciudad de Guatemala, Guatemala
Final Avenida Hincapie oficina No. 6 Zona 13 Zona 13, Ciudad de Guatemala, Guatemala
Avenida Las Americas 9-08, Zona 14, Guatemala City, Guatemala
8 Calle 3-67 Zona 10, Guatemala City, Guatemala
=end
puts "********* Starting Retailers ***********"
# Kohl's
retailer = RetailerSeed.create!(
  :account_id     => Account.where(:name => "Kohl's Department Stores").first.id,
  :name           => "Kohl's",
  :address        => "4A Avenida, Zona 1",
  :city           => "Ciudad de Guatemala",
  :state          => "Guatemala",
  :phone          => "555-555-1212",
  :contact_name   => "Bob Evans",
  :contact_email  => "bob.e@kohls.com",
  :url            => "www.kohls.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now,
  :retailer_category_id => RetailerCategory.where(:retailer_category => "All offers - Todas las Ofertas").first.id
)
zone = Map.which_zone?( [ retailer.latitude, retailer.longitude ] )
retailer.update_attribute( :zone, zone ||= 0 )
puts "    Kohl's Retailer created"
# Radio Shack
retailer = RetailerSeed.create!(
  :account_id     => Account.where(:name => "Radio Shack Stores").first.id,
  :name           => "Radio Shack",
  :address        => "9na. Calle 'A' 3-20 Zona 1",
  :city           => "Ciudad de Guatemala",
  :state          => "Guatemala",
  :phone          => "555-555-1212",
  :contact_name   => "George McCartney",
  :contact_email  => "georgemc@radioshack.com",
  :url            => "www.radioshack.com",
  :created_at => DateTime.now,
  :updated_at => DateTime.now,
  :retailer_category_id => RetailerCategory.where(:retailer_category => "Entertainment - Entretenimiento").first.id
)
zone = Map.which_zone?( [ retailer.latitude, retailer.longitude ] )
retailer.update_attribute( :zone, zone ||= 0 )
puts "    Radio Shack Retailer created"
# Sears
retailer = RetailerSeed.create!(
  :account_id     => Account.where(:name => "Sears Stores LLC").first.id,
  :name           => "Sears",
  :address        => "Km.14.5 Carr. El Salvador C.C. Escala L.#30",
  :city           => "Ciudad de Guatemala",
  :state          => "Guatemala",
  :phone          => "555-555-1212",
  :contact_name   => "Edgar Winter",
  :contact_email  => "edgwinter@sears.com",
  :url            => "www.sears.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now,
  :retailer_category_id => RetailerCategory.where(:retailer_category => "All offers - Todas las Ofertas").first.id
)
zone = Map.which_zone?( [ retailer.latitude, retailer.longitude ] )
retailer.update_attribute( :zone, zone ||= 0 )
puts "    Sears Retailer created"
# NOTE: these next 2 retailers are associated with the same Account
# Billy's Heli Shop (BKDK)
retailer = RetailerSeed.create!(
  :account_id     => Account.where(:name => "BKDK LLC").first.id,
  :name           => "Billy's Heli Shop",
  :address        => "Via 5 4-68 Zona 4",
  :city           => "Guatemala City",
  :state          => "Guatemala",
  :phone          => "555-555-1212",
  :contact_name   => "Billy Kiskin",
  :contact_email  => "bill@myemailprovider.com",
  :url            => "www.billyshelishop.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now,
  :retailer_category_id => RetailerCategory.where(:retailer_category => "Entertainment - Entretenimiento").first.id
)
zone = Map.which_zone?( [ retailer.latitude, retailer.longitude ] )
retailer.update_attribute( :zone, zone ||= 0 )
puts "    Billy's Heli Shop Retailer created"
# Darlene's Boutique (BKDK)
retailer = RetailerSeed.create!(
  :account_id     => Account.where(:name => "BKDK LLC").first.id,
  :name           => "Darlene's Boutique",
  :address        => "14.579160, -90.471768", # 14.579160, -90.471768  "8 Calle 3-67 Zona 10, Guatemala City, Guatemala"
  :city           => "      ",
  :state          => "      ",
  :phone          => "555-555-1212",
  :contact_name   => "Billy Kiskin",
  :contact_email  => "luc@renoemail.com",
  :url            => "www.darlenesboutique.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now,
  :retailer_category_id => RetailerCategory.where(:retailer_category => "Services - Servicios").first.id
)
zone = Map.which_zone?( [ retailer.latitude, retailer.longitude ] )
retailer.update_attribute( :zone, zone ||= 0 )
puts "    Darlene's Boutique Retailer created"
# Half Price Books
retailer = RetailerSeed.create!(
  :account_id     => Account.where(:name => "Half Price Books Stores LLC").first.id,
  :name           => "Half Price Books",
  :address        => "Manzana K Casa 7 Residenciales Villas Alameda Zona 18",
  :city           => "Ciudad de Guatemala",
  :state          => "Guatemala",
  :phone          => "555-555-1212",
  :contact_name   => "Ariel Lucky",
  :contact_email  => "ariel@hpbooks.com",
  :url            => "www.hpbooks.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now,
  :retailer_category_id => RetailerCategory.where(:retailer_category => "Entertainment - Entretenimiento").first.id
)
zone = Map.which_zone?( [ retailer.latitude, retailer.longitude ] )
retailer.update_attribute( :zone, zone ||= 0 )
puts "    Half Price Books Retailer created"
# Kristian's Scuba King
retailer = RetailerSeed.create!(
  :account_id     => Account.where(:name => "HoJoLeLa LLC").first.id,
  :name           => "Kristian's Scuba King",
  :address        => "Ruta 3 Via 5 esquina Zona 4",
  :city           => "Ciudad de Guatemala",
  :state          => "Guatemala",
  :phone          => "555-555-1212",
  :contact_name   => "Kristian Takvham",
  :contact_email  => "kt@scubaking.com",
  :url            => "www.scubaking.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now,
  :retailer_category_id => RetailerCategory.where(:retailer_category => "Services - Servicios").first.id
)
zone = Map.which_zone?( [ retailer.latitude, retailer.longitude ] )
retailer.update_attribute( :zone, zone ||= 0 )
puts "    Kristian's Scuba King Retailer created"
# Walgreen's Stores LLC
retailer = RetailerSeed.create!(
  :account_id     => Account.where(:name => "Walgreen's Stores LLC").first.id,
  :name           => "Walgreen's Pharmacy",
  :address        => "Bulevar Vista Hermosa 17-30 Plaza Nahum oficina 102 Zona 15",
  :city           => "Ciudad de Guatemala",
  :state          => "Guatemala",
  :phone          => "555-555-1212",
  :contact_name   => "Darrel Divins",
  :contact_email  => "ddivins@walgreens.com",
  :url            => "www.walgreens.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now,
  :retailer_category_id => RetailerCategory.where(:retailer_category => "Health and Beauty- Salud y Belleza").first.id
)
zone = Map.which_zone?( [ retailer.latitude, retailer.longitude ] )
retailer.update_attribute( :zone, zone ||= 0 )
puts "    Walgreen's Pharmacy Retailer created (zone 4)"
# Walgreen's Stores LLC
retailer = RetailerSeed.create!(
  :account_id     => Account.where(:name => "Walgreen's Stores LLC").first.id,
  :name           => "Walgreen's Pharmacy",
  :address        => "Parque Comercial Majadas, Zona 11",
  :city           => "Ciudad de Guatemala",
  :state          => "Guatemala",
  :phone          => "555-555-1212",
  :contact_name   => "Darrel Divins",
  :contact_email  => "ddivins@walgreens.com",
  :url            => "www.walgreens.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now,
  :retailer_category_id => RetailerCategory.where(:retailer_category => "Health and Beauty- Salud y Belleza").first.id
)
zone = Map.which_zone?( [ retailer.latitude, retailer.longitude ] )
retailer.update_attribute( :zone, zone ||= 0 )
puts "    Walgreen's Pharmacy Retailer created (zone 1)"
# Home Depot
retailer = RetailerSeed.create!(
  :account_id     => Account.where(:name => "Home Depot Stores").first.id,
  :name           => "Home Depot",
  :address        => "1ra. Calle 37-11 Colonia Toledo Zona 11",
  :city           => "Ciudad de Guatemala",
  :state          => "Guatemala",
  :phone          => "(214) 343-1032",
  :contact_name   => "Scott Johnson",
  :contact_email  => "scott.johnson@homedepot.com",
  :url            => "www.homedepot.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now,
  :retailer_category_id => RetailerCategory.where(:retailer_category => "Services - Servicios").first.id
)
zone = Map.which_zone?( [ retailer.latitude, retailer.longitude ] )
retailer.update_attribute( :zone, zone ||= 0 )
puts "    Home Depot Retailer created"
# Herb's Paint and Body
retailer = RetailerSeed.create!(
  :account_id     => Account.where(:name => "Herb's Paint and Body Shops LLC").first.id,
  :name           => "Herb's Paint and Body #6",
  :address        => "12 Calle, Zona 11",
  :city           => "Ciudad de Guatemala",
  :state          => "Guatemala",
  :phone          => "(214) 366-2155",
  :contact_name   => "Herbie Hancock",
  :contact_email  => "herbie.hancock@herbspaintandbody.com",
  :url            => "www.herbspaintandbody.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now,
  :retailer_category_id => RetailerCategory.where(:retailer_category => "Services - Servicios").first.id
)
zone = Map.which_zone?( [ retailer.latitude, retailer.longitude ] )
retailer.update_attribute( :zone, zone ||= 0 )
puts "    Herb's Paint and Body #6 Retailer created"
# Fry's Electronics #1
retailer = RetailerSeed.create!(
  :account_id     => Account.where(:name => "Fry's Electronics Stores LLC").first.id,
  :name           => "Fry's Electronics",
  :address        => "Av. Reforma 13-70 Zona 9 Edificio Real Reforma - Primer Nivel",
  :city           => "Ciudad de Guatemala",
  :state          => "Guatemala",
  :phone          => "(214) 342-5900",
  :contact_name   => "Gerald Hansen",
  :contact_email  => "gerald.hansenk@outpost.com",
  :url            => "www.outpost.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now,
  :retailer_category_id => RetailerCategory.where(:retailer_category => "Entertainment - Entretenimiento").first.id
)
zone = Map.which_zone?( [ retailer.latitude, retailer.longitude ] )
retailer.update_attribute( :zone, zone ||= 0 )
puts "    Fry's Electronics Retailer #1 created"
# Fry's Electronics #2  (:name => "Fry's Electronics", :address => "20 Calle 10-17 Aurora II Zona 13", :city => "Ciudad de Guatemala", :state => "Guatemala").
retailer = RetailerSeed.create!(
  :account_id     => Account.where(:name => "Fry's Electronics Stores LLC").first.id,
  :name           => "Fry's Electronics",
  :address        => "20 Calle 10-17 Aurora II Zona 13",
  :city           => "Ciudad de Guatemala",
  :state          => "Guatemala",
  :phone          => "(214) 291-6000",
  :contact_name   => "Taylor Smith",
  :contact_email  => "taylor.smith@outpost.com",
  :url            => "www.outpost.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now,
  :retailer_category_id => RetailerCategory.where(:retailer_category => "Entertainment - Entretenimiento").first.id
)
zone = Map.which_zone?( [ retailer.latitude, retailer.longitude ] )
retailer.update_attribute( :zone, zone ||= 0 )
puts "    Fry's Electronics Retailer #2 created"

puts "Retailers created using RetailerSeed"

AdvertiserType.create!(:advertiser_type => "online", :description => "Advertiser has only an online presence, no physical stores or outlets")
AdvertiserType.create!(:advertiser_type => "physical", :description => "Advertiser has a physical presence and can optionally have an online presence")

puts "Advertiser Types created"
 
# NOTE:  A Retailer can also be the Advertiser as in the case of a Mom and Pop Shop (sole proprietorship) that has its own advertisement.  
# In that case the Advertiser record has a "retailer_id" that points to the a Retailer.  If the Advertiser is not the store itself then the
# rest of the fields are filled in with no "retailer_id" needed since the advertiser in this case is a distinct entity unrelated to the retailer
puts "********* Starting Advertisers ***********"
# Retailer = Advertiser
advertiser = Advertiser.create!(
  :advertiser_type_id => AdvertiserType.where(:advertiser_type => "physical").first.id,
  :retailer_id        => Retailer.where(:name     => "Kristian's Scuba King", 
                                        :address  => "Ruta 3 Via 5 esquina Zona 4",
                                        :city     => "Ciudad de Guatemala",
                                        :state    => "Guatemala").first.id )
puts "    #{advertiser.retailer.name} Advertiser created"
# Retailer = Advertiser
advertiser = Advertiser.create!(
  :advertiser_type_id => AdvertiserType.where(:advertiser_type => "physical").first.id,
  :retailer_id        => Retailer.where(:name => "Darlene's Boutique", 
                                        :address        => "14.579160, -90.471768",
                                        :city           => "      ",
                                        :state          => "      ").first.id )
puts "    #{advertiser.retailer.name} Advertiser created"
# Retailer = Advertiser
advertiser = Advertiser.create!(
  :advertiser_type_id => AdvertiserType.where(:advertiser_type => "physical").first.id,
  :retailer_id        => Retailer.where(:name     => "Fry's Electronics", 
                                        :address  => "Av. Reforma 13-70 Zona 9 Edificio Real Reforma - Primer Nivel",
                                        :city     => "Ciudad de Guatemala",
                                        :state    => "Guatemala" ).first.id )
puts "    #{advertiser.retailer.name} Advertiser created"
# Retailer = Advertiser
advertiser = Advertiser.create!(
  :advertiser_type_id => AdvertiserType.where(:advertiser_type => "physical").first.id,
  :retailer_id        => Retailer.where(:name     => "Billy's Heli Shop",
                                        :address  => "Via 5 4-68 Zona 4",
                                        :city     => "Guatemala City",
                                        :state    => "Guatemala").first.id )
puts "    #{advertiser.retailer.name} Advertiser created"

# Distinct Advertiser
advertiser = Advertiser.create!(
  :advertiser_type_id => AdvertiserType.where(:advertiser_type => "physical").first.id,
  :retailer_id => nil,
  :name => "Proctor & Gamble",
  :address => "5299 Spring Grove Ave",
  :city => "Cincinnati",
  :state => "OH, 45202",
  # :zip => "45202",
  :phone => "(513) 983-1100",
  :created_at => DateTime.now,
  :updated_at => DateTime.now,
)  
puts "    #{advertiser.name} Advertiser created"
# Distinct Advertiser
advertiser = Advertiser.create!(
  :advertiser_type_id => AdvertiserType.where(:advertiser_type => "online").first.id,
  :retailer_id => nil,
  :name => "Amazon.com, Inc.",
  :address => "1200 12th Ave. South, Ste. 1200",
  :city => "Seattle",
  :state => "WA, 98144-2734",
  # :zip => "98144-2734",
  :phone => "206-266-1000",
  :created_at => DateTime.now,
  :updated_at => DateTime.now,
)  
puts "    #{advertiser.name} Advertiser created"
# Distinct Advertiser
advertiser = Advertiser.create!(
  :advertiser_type_id => AdvertiserType.where(:advertiser_type => "physical").first.id,
  :retailer_id => nil,
  :name => "Walgreens's Corporate",
  :address => "200 Wilmot Road",
  :city => "Deerfield",
  :state => "IL, 60015",
  # :zip => "60015",
  :phone => "206-266-1000",
  :created_at => DateTime.now,
  :updated_at => DateTime.now
)  
puts "    #{advertiser.name} Advertiser created"
# Distinct Advertiser
advertiser = Advertiser.create!(
  :advertiser_type_id => AdvertiserType.where(:advertiser_type => "physical").first.id,
  :retailer_id => nil,
  :name => "Kohl's Corporate",
  :address => "N56W17000 Ridgewood Drive",
  :city => "Menomonee Falls",
  :state => "WI, 53201-0359",
  # :zip => "53201-0359",
  :phone => "(262) 703-7000",
  :created_at => DateTime.now,
  :updated_at => DateTime.now
)  
puts "    #{advertiser.name} Advertiser created"
# Distinct Advertiser
advertiser = Advertiser.create!(
  :advertiser_type_id => AdvertiserType.where(:advertiser_type => "physical").first.id,
  :retailer_id => nil,
  :name => "Radio Shack Corporate",
  :address => "300 Radio Shack Circle",
  :city => "Fort Worth",
  :state => "TX, 76102-1964",
  # :zip => "76102-1964",
  :phone => "(817) 415-3700",
  :created_at => DateTime.now,
  :updated_at => DateTime.now
)  
puts "    #{advertiser.name} Advertiser created"
# Distinct Advertiser
advertiser = Advertiser.create!(
  :advertiser_type_id => AdvertiserType.where(:advertiser_type => "physical").first.id,
  :retailer_id => nil,
  :name => "Sears Corporate",
  :address => "3333 Beverly Road",
  :city => "Hoffman Estates",
  :state => "IL, 60179",
  # :zip => "60179",
  :phone => "(847) 286-2500",
  :created_at => DateTime.now,
  :updated_at => DateTime.now
)  
puts "    #{advertiser.name} Advertiser created"
# Distinct Advertiser
advertiser = Advertiser.create!(
  :advertiser_type_id => AdvertiserType.where(:advertiser_type => "physical").first.id,
  :retailer_id => nil,
  :name => "Home Depot Corporate",
  :address => "2455 Paces Ferry Rd SE",
  :city => "Atlanta",
  :state => "GA, 30339",
  # :zip => "30339",
  :phone => "(800)-466-3337",
  :created_at => DateTime.now,
  :updated_at => DateTime.now
)  
puts "    #{advertiser.name} Advertiser created"
# Distinct Advertiser
advertiser = Advertiser.create!(
  :advertiser_type_id => AdvertiserType.where(:advertiser_type => "physical").first.id,
  :retailer_id => nil,
  :name => "Fry's Electronics Incorporated Corporate",
  :address => "600 E Brokaw Rd",
  :city => "San Jose",
  :state => "CA, 95112",
  # :zip => "95112",
  :phone => "(408) 487-4500",
  :created_at => DateTime.now,
  :updated_at => DateTime.now
)  
puts "    #{advertiser.name} Advertiser created"
# Distinct Advertiser
advertiser = Advertiser.create!(
  :advertiser_type_id => AdvertiserType.where(:advertiser_type => "physical").first.id,
  :retailer_id => nil,
  :name => "Herb's Paint and Body #1 Corporate",
  :address => "12101 Self Plaza Drive",
  :city => "Dallas",
  :state => "TX, 75218",
  # :zip => "75218",
  :phone => "(214) 328-4381",
  :created_at => DateTime.now,
  :updated_at => DateTime.now
)  
puts "    #{advertiser.name} Advertiser created"
advertiser = Advertiser.create!(
  :advertiser_type_id => AdvertiserType.where(:advertiser_type => "physical").first.id,
  :retailer_id => nil,
  :name => "Half Price Books Corporate",
  :address        => "5803 East Northwest Highway",
  :city           => "Dallas",
  :state          => "TX, 75232",
  # :zip            => "75232",
  :phone          => "555-555-5555",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now
)  
puts "    #{advertiser.name} Advertiser created"

puts "Advertisers Created"

# Deals are like advertisement in that they offer "deals" but do require the deal to be redeemed at the point of purchase.
# Deals are associated with Retailers and Advertisers so that "Retailers have many advertisers through deals".

DealType.create!(:deal_type => "DDI",  :description => "Dollar Discount on the Item => fixed dollar amount taken from the item's price")
DealType.create!(:deal_type => "DDT",  :description => "Dollar Discount on the Total => fixed dollar amount taken from the final total")
DealType.create!(:deal_type => "PDI",   :description => "Percentage Discount on the Item => percentage of the item price taken from the item's price")
DealType.create!(:deal_type => "PDT",   :description => "Percentage Discount on the Total => percentage of the items total taken from the items' total")

puts "Deal Types created"
puts "********* Starting Deals ***********"
# dc = DealsController.new
deal = DealSeed.create!(
  :deal_type_id             => DealType.where(:deal_type => "PDI").first.id,
  :retailer_id              => Retailer.where(:name => "Walgreen's Pharmacy", :address => "Bulevar Vista Hermosa 17-30 Plaza Nahum oficina 102 Zona 15", :city => "Ciudad de Guatemala", :state => "Guatemala").first.id,
  :advertiser_id            => Advertiser.where(:name => "Walgreens's Corporate").first.id,
  :name                     => "99% off Select Items",
  :description              => "All of our Summer clothing and flip-flops are on sale",
  :content                  => "Deal html or url goes here...",
  :featured_flag            => 1,
  :num_offered              => 100,
  :beg_date                 => "2012-02-01",
  :end_date                 => "2012-02-27",
  # :badge_text               => "99% Off!",
  :image                    => 'IMGA0019.jpg',
  :discount_percent_text    => "51%", 
  :discount_amount_text     => "$10",
  :price_text               => "$29", 
  :fine_print_text          => "fine print",
  :deal_tag_text            => "GET IT $29",
  :preview_flag             => 0,
  :skeleton_flag            => 0,
  :gender                   => "B",
  :retailer_latitude        => Retailer.where(:name => "Walgreen's Pharmacy", :address => "Bulevar Vista Hermosa 17-30 Plaza Nahum oficina 102 Zona 15", :city => "Ciudad de Guatemala", :state => "Guatemala").first.latitude,
  :retailer_longitude       => Retailer.where(:name => "Walgreen's Pharmacy", :address => "Bulevar Vista Hermosa 17-30 Plaza Nahum oficina 102 Zona 15", :city => "Ciudad de Guatemala", :state => "Guatemala").first.longitude,
  :active_flag              => 1,
  :created_at               => DateTime.now,
  :updated_at               => DateTime.now,
  :share_to_unlock_pct      => "+15%",
  :social_discount_interval => 5,
  :redemption_passphrase    => "La ausencia hace crecer el cariño (Absence makes the heart grow fonder)"
)
zone = Map.which_zone?( [ deal.retailer_latitude, deal.retailer_longitude ] )
deal.update_attribute( :retailer_zone, zone ||= 0 )
puts "  Walgreen's Pharmacy Zone 4 deal 1 (featured) created"

DeviceRedemption.create!(:device_uid => "guid-1", :deal_id => deal.id, :redemption_type => "G", :redemption_date => Date.today )
puts "     'GetIt' DeviceRedemption created for Deal #{deal.name}"
DeviceRedemption.create!(:device_uid => "guid-1", :deal_id => deal.id, :redemption_type => "S", :redemption_date => Date.today )
puts "     'GetIt' DeviceRedemption created for Deal #{deal.name}"

# puts "#{dc.make_badge( deal.badge_text, deal)}" # updates "badge_path" 
deal = DealSeed.create!(
  :deal_type_id             => DealType.where(:deal_type => "PDI").first.id,
  :retailer_id              => Retailer.where(:name => "Walgreen's Pharmacy", :address => "Bulevar Vista Hermosa 17-30 Plaza Nahum oficina 102 Zona 15", :city => "Ciudad de Guatemala", :state => "Guatemala").first.id,
  :advertiser_id            => Advertiser.where(:name => "Walgreens's Corporate").first.id,
  :name                     => "Candy Sale 50% off",
  :description              => "All Halloween candy will be on sale just after Halloween",
  :content                  => "Deal html or url goes here...",
  :featured_flag            => 0,
  :num_offered              => 100,
  :beg_date                 => "2012-02-01",
  :end_date                 => "2012-03-31",
#  :badge_text               => "50% Off!",
  :image                    => "image placeholder",
  :discount_percent_text    => "33%", 
  :discount_amount_text     => "$20",
  :price_text               => "$82", 
  :fine_print_text          => "fine print",
  :deal_tag_text            => "GET IT $82",
  :preview_flag             => 0,
  :skeleton_flag            => 0,
  :gender                   => "B",
  :retailer_latitude        => Retailer.where(:name => "Walgreen's Pharmacy", :address => "Bulevar Vista Hermosa 17-30 Plaza Nahum oficina 102 Zona 15", :city => "Ciudad de Guatemala", :state => "Guatemala").first.latitude,
  :retailer_longitude       => Retailer.where(:name => "Walgreen's Pharmacy", :address => "Bulevar Vista Hermosa 17-30 Plaza Nahum oficina 102 Zona 15", :city => "Ciudad de Guatemala", :state => "Guatemala").first.longitude,
  :active_flag              => 1,
  :created_at               => DateTime.now,
  :updated_at               => DateTime.now,
  :share_to_unlock_pct      => "+15%",
  :social_discount_interval => 5,
  :redemption_passphrase    => "La belleza es sólo superficial (Beauty is only skin deep)"
)
zone = Map.which_zone?( [ deal.retailer_latitude, deal.retailer_longitude ] )
deal.update_attribute( :retailer_zone, zone ||= 0 )
puts "  Walgreen's Pharmacy Zone 4 deal 2 (non-featured) created"
# puts "#{dc.make_badge( deal.badge_text, deal)}"
deal = DealSeed.create!(
  :deal_type_id             => DealType.where(:deal_type => "PDI").first.id,
  :retailer_id              => Retailer.where(:name => "Walgreen's Pharmacy", :address => "Parque Comercial Majadas, Zona 11", :city => "Ciudad de Guatemala", :state => "Guatemala").first.id,
  :advertiser_id            => Advertiser.where(:name => "Walgreens's Corporate").first.id,
  :name                     => "Summer Attire all ON SALE!",
  :description              => "All Summer Attire including flip-flops, sandals, t-shirts will be on sale at 50% Off!",
  :content                  => "Deal html or url goes here...",
  :featured_flag            => 0,
  :num_offered              => 100,
  :beg_date                 => "2012-02-01",
  :end_date                 => "2012-03-31",
#  :badge_text               => "50% Off!",
  :image                    => "image placeholder",
  :discount_percent_text    => "50%", 
  :discount_amount_text     => "$12",
  :price_text               => "$16", 
  :fine_print_text          => "fine print goes here, just ignore it",
  :deal_tag_text            => "GET IT $16",
  :preview_flag             => 0,
  :skeleton_flag            => 0,
  :gender                   => "B",
  :retailer_latitude        => Retailer.where(:name => "Walgreen's Pharmacy", :address => "Parque Comercial Majadas, Zona 11", :city => "Ciudad de Guatemala", :state => "Guatemala").first.latitude,
  :retailer_longitude       => Retailer.where(:name => "Walgreen's Pharmacy", :address => "Parque Comercial Majadas, Zona 11", :city => "Ciudad de Guatemala", :state => "Guatemala").first.longitude,
  :active_flag              => 1,
  :created_at               => DateTime.now,
  :updated_at               => DateTime.now,
  :share_to_unlock_pct      => "+12%",
  :social_discount_interval => 5,
  :redemption_passphrase    => "Luna clara, las heladas muy pronto (Clear moon, frost soon)"
)
zone = Map.which_zone?( [ deal.retailer_latitude, deal.retailer_longitude ] )
deal.update_attribute( :retailer_zone, zone ||= 0 )
puts "  Walgreen's Pharmacy Zone 1 deal 1 (non-featured) created"
deal = DealSeed.create!(
  :deal_type_id             => DealType.where(:deal_type => "PDI").first.id,
  :retailer_id              => Retailer.where(:name => "Walgreen's Pharmacy", :address => "Parque Comercial Majadas, Zona 11", :city => "Ciudad de Guatemala", :state => "Guatemala").first.id,
  :advertiser_id            => Advertiser.where(:name => "Walgreens's Corporate").first.id,
  :name                     => "Shampoos all on Sale!",
  :description              => "All shampoos and conditioners at 44% Off!",
  :content                  => "Deal html or url goes here...",
  :featured_flag            => 1,
  :num_offered              => 100,
  :beg_date                 => "2012-02-01",
  :end_date                 => "2012-03-31",
#  :badge_text               => "50% Off!",
  :image                    => "image placeholder",
  :discount_percent_text    => "44%", 
  :discount_amount_text     => "$3",
  :price_text               => "$6", 
  :fine_print_text          => "fine print goes here, just ignore it",
  :deal_tag_text            => "GET IT $6",
  :preview_flag             => 0,
  :skeleton_flag            => 0,
  :gender                   => "B",
  :retailer_latitude        => Retailer.where(:name => "Walgreen's Pharmacy", :address => "Parque Comercial Majadas, Zona 11", :city => "Ciudad de Guatemala", :state => "Guatemala").first.latitude,
  :retailer_longitude       => Retailer.where(:name => "Walgreen's Pharmacy", :address => "Parque Comercial Majadas, Zona 11", :city => "Ciudad de Guatemala", :state => "Guatemala").first.longitude,
  :active_flag              => 1,
  :created_at               => DateTime.now,
  :updated_at               => DateTime.now,
  :share_to_unlock_pct      => "+12%",
  :social_discount_interval => 5,
  :redemption_passphrase    => "La discreción es la mejor parte del valor (Discretion is the better part of valour)"
)
zone = Map.which_zone?( [ deal.retailer_latitude, deal.retailer_longitude ] )
deal.update_attribute( :retailer_zone, zone ||= 0 )
puts "  Walgreen's Pharmacy Zone 1 deal 2 (featured) created"

deal = DealSeed.create!(
  :deal_type_id             => DealType.where(:deal_type => "PDI").first.id,
  :retailer_id              => Retailer.where(:name => "Walgreen's Pharmacy", :address => "Parque Comercial Majadas, Zona 11", :city => "Ciudad de Guatemala", :state => "Guatemala").first.id,
  :advertiser_id            => Advertiser.where(:name => "Walgreens's Corporate").first.id,
  :name                     => "Cleaning Supplies on SALE!!!",
  :description              => "Choose from Tide, Spic-n-Span, and a host of other fine cleaners",
  :content                  => "Deal html or url goes here...",
  :featured_flag            => 1,
  :num_offered              => 100,
  :beg_date                 => "2012-02-01",
  :end_date                 => "2012-03-31",
#  :badge_text               => "50% Off!",
  :image                    => "image placeholder",
  :discount_percent_text    => "22%", 
  :discount_amount_text     => "$5",
  :price_text               => "$7", 
  :fine_print_text          => "fine print goes here, just ignore it",
  :deal_tag_text            => "GET IT $7",
  :preview_flag             => 0,
  :skeleton_flag            => 0,
  :gender                   => "B",
  :retailer_latitude        => Retailer.where(:name => "Walgreen's Pharmacy", :address => "Parque Comercial Majadas, Zona 11", :city => "Ciudad de Guatemala", :state => "Guatemala").first.latitude,
  :retailer_longitude       => Retailer.where(:name => "Walgreen's Pharmacy", :address => "Parque Comercial Majadas, Zona 11", :city => "Ciudad de Guatemala", :state => "Guatemala").first.longitude,
  :active_flag              => 1,
  :created_at               => DateTime.now,
  :updated_at               => DateTime.now,
  :share_to_unlock_pct      => "+10%",
  :social_discount_interval => 5,
  :redemption_passphrase    => "Fácil viene, fácil se va (Easy come, easy go)"
)
zone = Map.which_zone?( [ deal.retailer_latitude, deal.retailer_longitude ] )
deal.update_attribute( :retailer_zone, zone ||= 0 )
puts "  Walgreen's Pharmacy Zone 1 deal 3 (featured) created"

deal = DealSeed.create!(
  :deal_type_id             => DealType.where(:deal_type => "PDI").first.id,
  :retailer_id              => Retailer.where(:name => "Walgreen's Pharmacy", :address => "Parque Comercial Majadas, Zona 11", :city => "Ciudad de Guatemala", :state => "Guatemala").first.id,
  :advertiser_id            => Advertiser.where(:name => "Walgreens's Corporate").first.id,
  :name                     => "Multi Vitamins for All!",
  :description              => "One-a-Day Multivitamins on sale for you better health",
  :content                  => "Deal html or url goes here...",
  :featured_flag            => 0,
  :num_offered              => 100,
  :beg_date                 => "2012-02-01",
  :end_date                 => "2012-03-31",
#  :badge_text               => "50% Off!",
  :image                    => "image placeholder",
  :discount_percent_text    => "33%", 
  :discount_amount_text     => "$2",
  :price_text               => "$5", 
  :fine_print_text          => "fine print goes here, just ignore it",
  :deal_tag_text            => "GET IT $5",
  :preview_flag             => 0,
  :skeleton_flag            => 0,
  :gender                   => "B",
  :retailer_latitude        => Retailer.where(:name => "Walgreen's Pharmacy", :address => "Parque Comercial Majadas, Zona 11", :city => "Ciudad de Guatemala", :state => "Guatemala").first.latitude,
  :retailer_longitude       => Retailer.where(:name => "Walgreen's Pharmacy", :address => "Parque Comercial Majadas, Zona 11", :city => "Ciudad de Guatemala", :state => "Guatemala").first.longitude,
  :active_flag              => 1,
  :created_at               => DateTime.now,
  :updated_at               => DateTime.now,
  :share_to_unlock_pct      => "+15%",
  :social_discount_interval => 5,
  :redemption_passphrase    => "Primero lo primero (First things first)"
)
zone = Map.which_zone?( [ deal.retailer_latitude, deal.retailer_longitude ] )
deal.update_attribute( :retailer_zone, zone ||= 0 )
puts "  Walgreen's Pharmacy Zone 1 deal 4 (non-featured) created"

deal = DealSeed.create!(
  :deal_type_id             => DealType.where(:deal_type => "PDI").first.id,
  :retailer_id              => Retailer.where(:name => "Walgreen's Pharmacy", :address => "Parque Comercial Majadas, Zona 11", :city => "Ciudad de Guatemala", :state => "Guatemala").first.id,
  :advertiser_id            => Advertiser.where(:name => "Walgreens's Corporate").first.id,
  :name                     => "Gaines Burgers Dog Food Special!",
  :description              => "For your pet's health and vitality get Gaines Burgers Dog Food and your pet will love you, and be more healthy at the same time.",
  :content                  => "Deal html or url goes here...",
  :featured_flag            => 0,
  :num_offered              => 100,
  :beg_date                 => "2012-02-01",
  :end_date                 => "2012-03-31",
#  :badge_text               => "50% Off!",
  :image                    => "image placeholder",
  :discount_percent_text    => "25%", 
  :discount_amount_text     => "$3",
  :price_text               => "$8", 
  :fine_print_text          => "fine print goes here, just ignore it",
  :deal_tag_text            => "GET IT $8",
  :preview_flag             => 0,
  :skeleton_flag            => 0,
  :gender                   => "B",
  :retailer_latitude        => Retailer.where(:name => "Walgreen's Pharmacy", :address => "Parque Comercial Majadas, Zona 11", :city => "Ciudad de Guatemala", :state => "Guatemala").first.latitude,
  :retailer_longitude       => Retailer.where(:name => "Walgreen's Pharmacy", :address => "Parque Comercial Majadas, Zona 11", :city => "Ciudad de Guatemala", :state => "Guatemala").first.longitude,
  :active_flag              => 1,
  :created_at               => DateTime.now,
  :updated_at               => DateTime.now,
  :share_to_unlock_pct      => "+15%",
  :social_discount_interval => 5,
  :redemption_passphrase    => "Las grandes mentes piensan igual (Great minds think alike)"
)
zone = Map.which_zone?( [ deal.retailer_latitude, deal.retailer_longitude ] )
deal.update_attribute( :retailer_zone, zone ||= 0 )
puts "  Walgreen's Pharmacy Zone 1 deal 5 (non-featured) created"

deal = DealSeed.create!(
  :deal_type_id             => DealType.where(:deal_type => "PDI").first.id,
  :retailer_id              => Retailer.where(:name => "Kohl's", :address => "4A Avenida, Zona 1", :city => "Ciudad de Guatemala", :state => "Guatemala").first.id,
  :advertiser_id            => Advertiser.where(:name => "Kohl's Corporate").first.id,
  :name                     => "Big Fat Clothing Sale",
  :description              => "Big Sale!!! Take an additional 15% off all Summer Wear",
  :content                  => "Deal html or url goes here...",
  :featured_flag            => 1,
  :num_offered              => 50,
  :beg_date                 => "2012-02-01",
  :end_date                 => "2012-02-28",
#  :badge_text               => "15% Off!",
  :image                    => "image placeholder",
  :discount_percent_text    => "20%",
  :discount_amount_text     => "$15",
  :price_text               => "$19", 
  :fine_print_text          => "fine print",
  :deal_tag_text            => "GET IT $19",
  :preview_flag             => 0,
  :skeleton_flag            => 0,
  :gender                   => "B",
  :retailer_latitude        => Retailer.where(:name => "Kohl's", :address => "4A Avenida, Zona 1", :city => "Ciudad de Guatemala", :state => "Guatemala").first.latitude,
  :retailer_longitude       => Retailer.where(:name => "Kohl's", :address => "4A Avenida, Zona 1", :city => "Ciudad de Guatemala", :state => "Guatemala").first.longitude,
  :active_flag              => 1,
  :created_at               => DateTime.now,
  :updated_at               => DateTime.now,
  :share_to_unlock_pct      => "+15%",
  :social_discount_interval => 5,
  :redemption_passphrase    => "La mitad de un pan es mejor que nada (Half a loaf is better than none)"
)
zone = Map.which_zone?( [ deal.retailer_latitude, deal.retailer_longitude ] )
deal.update_attribute( :retailer_zone, zone ||= 0 )
puts "  Kohl's deal created"
# puts "#{dc.make_badge( deal.badge_text, deal)}"
deal = DealSeed.create!(
  :deal_type_id             => DealType.where(:deal_type => "PDI").first.id,
  :retailer_id              => Retailer.where(:name => "Radio Shack", :address => "9na. Calle 'A' 3-20 Zona 1", :city => "Ciudad de Guatemala", :state => "Guatemala").first.id,
  :advertiser_id            => Advertiser.where(:name => "Radio Shack Corporate").first.id,
  :name                     => "Half-Off Sale! 3 Days Only, Hurry!",
  :description              => "50% off all cellphones and battery terminals",
  :content                  => "Deal html or url goes here...",
  :featured_flag            => 1,
  :num_offered              => 10,
  :beg_date                 => "2012-02-01",
  :end_date                 => "2012-02-28",
#  :badge_text               => "50% Off!",
  :image                    => "image placeholder",
  :discount_percent_text    => "75%", 
  :discount_amount_text     => "$25",
  :price_text               => "$100", 
  :fine_print_text          => "fine print",
  :deal_tag_text            => "GET IT $100",
  :preview_flag             => 0,
  :skeleton_flag            => 0,
  :gender                   => "B",
  :retailer_latitude        => Retailer.where(:name => "Radio Shack", :address => "9na. Calle 'A' 3-20 Zona 1", :city => "Ciudad de Guatemala", :state => "Guatemala").first.latitude,
  :retailer_longitude       => Retailer.where(:name => "Radio Shack", :address => "9na. Calle 'A' 3-20 Zona 1", :city => "Ciudad de Guatemala", :state => "Guatemala").first.longitude,
  :active_flag              => 1,
  :created_at               => DateTime.now,
  :updated_at               => DateTime.now,
  :share_to_unlock_pct      => "+15%",
  :social_discount_interval => 5,
  :redemption_passphrase    => "Es más oscuro antes del amanecer (It is always darkest before the dawn)"
)
zone = Map.which_zone?( [ deal.retailer_latitude, deal.retailer_longitude ] )
deal.update_attribute( :retailer_zone, zone ||= 0 )
puts "  Radio Shack deal created"
# puts "#{dc.make_badge( deal.badge_text, deal)}"
deal = DealSeed.create!(
  :deal_type_id             => DealType.where(:deal_type => "DDI").first.id,
  :retailer_id              => Retailer.where(:name => "Sears", :address => "Km.14.5 Carr. El Salvador C.C. Escala L.#30", :city => "Ciudad de Guatemala", :state => "Guatemala").first.id,
  :advertiser_id            => Advertiser.where(:name => "Sears Corporate").first.id,
  :name                     => "Big Tire Sale, Buy one get the other FREE!",
  :description              => "All tires are BOGO",
  :content                  => "Deal html or url goes here...",
  :featured_flag            => 1,
  :num_offered              => 5,
  :beg_date                 => "2012-02-01",
  :end_date                 => "2012-03-31",
#  :badge_text               => "Buy 1 Get 1",
  :image                    => "image placeholder",
  :discount_percent_text    => "12%", 
  :discount_amount_text     => "$19",
  :price_text               => "$10", 
  :fine_print_text          => "fine print",
  :deal_tag_text            => "GET IT $10",
  :preview_flag             => 0,
  :skeleton_flag            => 0,
  :gender                   => "B",
  :retailer_latitude        => Retailer.where(:name => "Sears", :address => "Km.14.5 Carr. El Salvador C.C. Escala L.#30", :city => "Ciudad de Guatemala", :state => "Guatemala").first.latitude,
  :retailer_longitude       => Retailer.where(:name => "Sears", :address => "Km.14.5 Carr. El Salvador C.C. Escala L.#30", :city => "Ciudad de Guatemala", :state => "Guatemala").first.longitude,
  :active_flag              => 1,
  :created_at               => DateTime.now,
  :updated_at               => DateTime.now,
  :share_to_unlock_pct      => "+15%",
  :social_discount_interval => 5,
  :redemption_passphrase    => "La justicia demorada es justicia denegada (Justice delayed is justice denied)"
)
zone = Map.which_zone?( [ deal.retailer_latitude, deal.retailer_longitude ] )
deal.update_attribute( :retailer_zone, zone ||= 0 )
puts "  Sears deal created"
# puts "#{dc.make_badge( deal.badge_text, deal)}"
# Home Depot
deal = DealSeed.create!(
  :deal_type_id             => DealType.where(:deal_type => "PDI").first.id,
  :retailer_id              => Retailer.where(:name => "Home Depot", :address => "1ra. Calle 37-11 Colonia Toledo Zona 11", :city => "Ciudad de Guatemala", :state => "Guatemala").first.id,
  :advertiser_id            => Advertiser.where(:name => "Home Depot Corporate").first.id,
  :name                     => "33% Off on all DeWalt Tools",
  :description              => "Take 33% off when you purchase any DeWalt cordless tool",
  :content                  => "Deal html or url goes here...",
  :featured_flag            => 1,
  :num_offered              => 1,
  :beg_date                 => "2012-02-01",
  :end_date                 => "2012-02-28",
#  :badge_text               => "33% Off!",
  :image                    => "image placeholder",
  :discount_percent_text    => "99%", 
  :discount_amount_text     => "$49",
  :price_text               => "$500", 
  :fine_print_text          => "fine print",
  :deal_tag_text            => "GET IT $500",
  :preview_flag             => 0,
  :skeleton_flag            => 0,
  :gender                   => "B",
  :retailer_latitude        => Retailer.where(:name => "Home Depot", :address => "1ra. Calle 37-11 Colonia Toledo Zona 11", :city => "Ciudad de Guatemala", :state => "Guatemala").first.latitude,
  :retailer_longitude       => Retailer.where(:name => "Home Depot", :address => "1ra. Calle 37-11 Colonia Toledo Zona 11", :city => "Ciudad de Guatemala", :state => "Guatemala").first.longitude,
  :active_flag              => 1,
  :created_at               => DateTime.now,
  :updated_at               => DateTime.now,
  :share_to_unlock_pct      => "+15%",
  :social_discount_interval => 5,
  :redemption_passphrase    => "El conocimiento es poder (Knowledge is power)"
)
zone = Map.which_zone?( [ deal.retailer_latitude, deal.retailer_longitude ] )
deal.update_attribute( :retailer_zone, zone ||= 0 )
puts "  Home Depot deal 1 created"
# puts "#{dc.make_badge( deal.badge_text, deal)}"
# Fry's where the local retailer is also the advertiser (not the corporate entity)
deal = DealSeed.create!(
  :deal_type_id             => DealType.where(:deal_type => "DDI").first.id,
  :retailer_id              => Retailer.where(:name => "Fry's Electronics", :address => "20 Calle 10-17 Aurora II Zona 13", :city => "Ciudad de Guatemala", :state => "Guatemala").first.id,
  :advertiser_id            => Advertiser.where(:retailer_id => (Retailer.where(:name => "Fry's Electronics", :address  => "Av. Reforma 13-70 Zona 9 Edificio Real Reforma - Primer Nivel", :city => "Ciudad de Guatemala", :state => "Guatemala").first.id)).first.id,
  :name                     => "$300.00 off LED 50\" Class Flat Panel TV",
  :description              => "Amazing savings",
  :content                  => "Deal html or url goes here...",
  :featured_flag            => 0,
  :num_offered              => 99,
  :beg_date                 => "2012-02-01",
  :end_date                 => "2012-02-28",
#  :badge_text               => "$300 Off!",
  :image                    => "image placeholder",
  :discount_percent_text    => "45%", 
  :discount_amount_text     => "$40",
  :price_text               => "$38", 
  :fine_print_text          => "fine print",
  :deal_tag_text            => "GET IT $38",
  :preview_flag             => 0,
  :skeleton_flag            => 0,
  :gender                   => "B",
  :retailer_latitude        => Retailer.where(:name => "Fry's Electronics", :address => "20 Calle 10-17 Aurora II Zona 13", :city => "Ciudad de Guatemala", :state => "Guatemala").first.latitude,
  :retailer_longitude       => Retailer.where(:name => "Fry's Electronics", :address => "20 Calle 10-17 Aurora II Zona 13", :city => "Ciudad de Guatemala", :state => "Guatemala").first.longitude,
  :active_flag              => 1,
  :created_at               => DateTime.now,
  :updated_at               => DateTime.now,
  :share_to_unlock_pct      => "+15%",
  :social_discount_interval => 5,
  :redemption_passphrase    => "La risa es la mejor medicina (Laughter is the best medicine)"
)
zone = Map.which_zone?( [ deal.retailer_latitude, deal.retailer_longitude ] )
deal.update_attribute( :retailer_zone, zone ||= 0 )
puts "  Fry's deal 1 created"
# puts "#{dc.make_badge( deal.badge_text, deal)}"
# Fry's where the local retailer is also the advertiser (not the corporate entity)
deal = DealSeed.create!(
  :deal_type_id             => DealType.where(:deal_type => "PDI").first.id,
  :retailer_id              => Retailer.where(:name => "Fry's Electronics", :address => "20 Calle 10-17 Aurora II Zona 13", :city => "Ciudad de Guatemala", :state => "Guatemala").first.id,
  :advertiser_id            => Advertiser.where(:retailer_id => (Retailer.where(:name => "Fry's Electronics", :address => "Av. Reforma 13-70 Zona 9 Edificio Real Reforma - Primer Nivel", :city => "Ciudad de Guatemala", :state => "Guatemala").first.id)).first.id,
  :name                     => "20% off Western Digital 1TB Hard Drive",
  :description              => "Amazing savings",
  :content                  => "Deal html or url goes here...",
  :featured_flag            => 1,
  :num_offered              => 100,
  :beg_date                 => "2012-02-01",
  :end_date                 => "2012-02-28",
#  :badge_text               => "20% Off!",
  :image                    => "image placeholder",
  :discount_percent_text    => "50%", 
  :discount_amount_text     => "$22",
  :price_text               => "$36", 
  :fine_print_text          => "fine print",
  :deal_tag_text            => "GET IT $36",
  :preview_flag             => 0,
  :skeleton_flag            => 0,
  :gender                   => "B",
  :retailer_latitude        => Retailer.where(:name => "Fry's Electronics", :address => "20 Calle 10-17 Aurora II Zona 13", :city => "Ciudad de Guatemala", :state => "Guatemala").first.latitude,
  :retailer_longitude       => Retailer.where(:name => "Fry's Electronics", :address => "20 Calle 10-17 Aurora II Zona 13", :city => "Ciudad de Guatemala", :state => "Guatemala").first.longitude,
  :active_flag              => 1,
  :created_at               => DateTime.now,
  :updated_at               => DateTime.now,
  :share_to_unlock_pct      => "+15%",
  :social_discount_interval => 5,
  :redemption_passphrase    => "Muchas manos aligeran el trabajo (Many hands make light work)"
)
zone = Map.which_zone?( [ deal.retailer_latitude, deal.retailer_longitude ] )
deal.update_attribute( :retailer_zone, zone ||= 0 )
puts "  Fry's deal 2 created"
# puts "#{dc.make_badge( deal.badge_text, deal)}"
# Herbs advertiser is Corporate
deal = DealSeed.create!(
  :deal_type_id             => DealType.where(:deal_type => "PDT").first.id,
  :retailer_id              => Retailer.where(:name => "Herb's Paint and Body #6", :address => "12 Calle, Zona 11", :city => "Ciudad de Guatemala", :state => "Guatemala").first.id,
  :advertiser_id            => Advertiser.where(:name => "Herb's Paint and Body #1 Corporate").first.id,
  :name                     => "Paint Job Discount of 25%",
  :description              => "Nice deal on all paint jobs, 25% off our already low regular price",
  :content                  => "Deal html or url goes here...",
  :featured_flag            => 1,
  :num_offered              => 100,
  :beg_date                 => "2012-02-01",
  :end_date                 => "2012-02-28",
#  :badge_text               => "25% Off!",
  :image                    => "image placeholder",
  :discount_percent_text    => "66%", 
  :discount_amount_text     => "$22",
  :price_text               => "$7", 
  :fine_print_text          => "fine print",
  :deal_tag_text            => "GET IT $7",
  :preview_flag             => 0,
  :skeleton_flag            => 0,
  :gender                   => "B",
  :retailer_latitude        => Retailer.where(:name => "Herb's Paint and Body #6", :address => "12 Calle, Zona 11", :city => "Ciudad de Guatemala", :state => "Guatemala").first.latitude,
  :retailer_longitude       => Retailer.where(:name => "Herb's Paint and Body #6", :address => "12 Calle, Zona 11", :city => "Ciudad de Guatemala", :state => "Guatemala").first.longitude,
  :active_flag              => 1,
  :created_at               => DateTime.now,
  :updated_at               => DateTime.now,
  :share_to_unlock_pct      => "+15%",
  :social_discount_interval => 5,
  :redemption_passphrase    => "Sin noticias es una buena noticia (No news is good news)"
)
zone = Map.which_zone?( [ deal.retailer_latitude, deal.retailer_longitude ] )
deal.update_attribute( :retailer_zone, zone ||= 0 )
puts "  Herb's Paint and Body #6 deal created"
# puts "#{dc.make_badge( deal.badge_text, deal)}"
# Home Depot
deal = DealSeed.create!(
  :deal_type_id             => DealType.where(:deal_type => "PDI").first.id,
  :retailer_id              => Retailer.where(:name => "Home Depot", :address => "1ra. Calle 37-11 Colonia Toledo Zona 11", :city => "Ciudad de Guatemala", :state => "Guatemala").first.id,
  :advertiser_id            => Advertiser.where(:name => "Home Depot Corporate").first.id,
  :name                     => "$1.00 off 96\" 2 x 4's",
  :description              => "Our low price of 1.98 for southern yellow pine lumber",
  :content                  => "Deal html or url goes here...",
  :featured_flag            => 1,
  :num_offered              => 1,
  :beg_date                 => "2012-02-01",
  :end_date                 => "2012-02-28",
#  :badge_text               => "$1.00 Off!",
  :image                    => "image placeholder",
  :discount_percent_text    => "40%", 
  :discount_amount_text     => "$27",
  :price_text               => "$5", 
  :fine_print_text          => "fine print",
  :deal_tag_text            => "GET IT $5",
  :preview_flag             => 0,
  :skeleton_flag            => 0,
  :gender                   => "B",
  :retailer_latitude        => Retailer.where(:name => "Home Depot", :address => "1ra. Calle 37-11 Colonia Toledo Zona 11", :city => "Ciudad de Guatemala", :state => "Guatemala").first.latitude,
  :retailer_longitude       => Retailer.where(:name => "Home Depot", :address => "1ra. Calle 37-11 Colonia Toledo Zona 11", :city => "Ciudad de Guatemala", :state => "Guatemala").first.longitude,
  :active_flag              => 1,
  :created_at               => DateTime.now,
  :updated_at               => DateTime.now,
  :share_to_unlock_pct      => "+15%",
  :social_discount_interval => 5,
  :redemption_passphrase    => "La basura de un hombre es el tesoro de otro hombre (One man's trash is another man's treasure)"
)
zone = Map.which_zone?( [ deal.retailer_latitude, deal.retailer_longitude ] )
deal.update_attribute( :retailer_zone, zone ||= 0 )
puts "  Home Depot deal 2 created"
# puts "#{dc.make_badge( deal.badge_text, deal)}"
# Billy's Heli Shop
deal = DealSeed.create!(
  :deal_type_id             => DealType.where(:deal_type => "DDI").first.id,
  :retailer_id              => Retailer.where(:name => "Billy's Heli Shop",:address => "Via 5 4-68 Zona 4", :city => "Guatemala City", :state => "Guatemala").first.id,
  :advertiser_id            => Advertiser.where(:retailer_id => (Retailer.where(:name => "Billy's Heli Shop",:address => "Via 5 4-68 Zona 4", :city => "Guatemala City", :state => "Guatemala").first.id)).first.id,
  :name                     => "Align 450 Super Combo $75.00 off regular price",
  :description              => "Amazing savings",
  :content                  => "Deal html or url goes here...",
  :featured_flag            => 1,
  :num_offered              => 1,
  :beg_date                 => "2012-02-01",
  :end_date                 => "2012-03-31",
#  :badge_text               => "$75 Off!",
  :image                    => "image placeholder",
  :discount_percent_text    => "30%", 
  :discount_amount_text     => "$27",
  :price_text               => "$69", 
  :fine_print_text          => "fine print",
  :deal_tag_text            => "GET IT $69",
  :preview_flag             => 0,
  :skeleton_flag            => 0,
  :gender                   => "B",
  :retailer_latitude        => Retailer.where(:name => "Billy's Heli Shop",:address => "Via 5 4-68 Zona 4", :city => "Guatemala City", :state => "Guatemala").first.latitude,
  :retailer_longitude       => Retailer.where(:name => "Billy's Heli Shop",:address => "Via 5 4-68 Zona 4", :city => "Guatemala City", :state => "Guatemala").first.longitude,
  :active_flag              => 1,
  :created_at               => DateTime.now,
  :updated_at               => DateTime.now,
  :share_to_unlock_pct      => "+15%",
  :social_discount_interval => 5,
  :redemption_passphrase    => "Penny Wise, en nimiedades (Penny wise, pound foolish)"
)
zone = Map.which_zone?( [ deal.retailer_latitude, deal.retailer_longitude ] )
deal.update_attribute( :retailer_zone, zone ||= 0 )
puts "  Billy's Heli Shop deal created"
# puts "#{dc.make_badge( deal.badge_text, deal)}"
# Darlene's Boutique
deal = DealSeed.create!(
  :deal_type_id             => DealType.where(:deal_type => "DDI").first.id,
  :retailer_id              => Retailer.where(:name => "Darlene's Boutique",:address => "14.579160, -90.471768", :city => "      ", :state => "      ").first.id,
  :advertiser_id            => Advertiser.where(:retailer_id => (Retailer.where(:name => "Darlene's Boutique",:address => "14.579160, -90.471768", :city => "      ", :state => "      ").first.id)).first.id,
  :name                     => "Designer Purses 50% off",
  :description              => "Get Amazing Savings on Designer Name Brand Purses",
  :content                  => "Deal html or url goes here...",
  :featured_flag            => 1,
  :num_offered              => 1,
  :beg_date                 => "2012-02-01",
  :end_date                 => "2012-03-31",
#  :badge_text               => "$25 Off!",
  :image                    => "image placeholder",
  :discount_percent_text    => "50%", 
  :discount_amount_text     => "$47",
  :price_text               => "$169", 
  :fine_print_text          => "fine print",
  :deal_tag_text            => "GET IT $169",
  :preview_flag             => 0,
  :skeleton_flag            => 0,
  :gender                   => "F",
  :retailer_latitude        => Retailer.where(:name => "Darlene's Boutique",:address => "14.579160, -90.471768", :city => "      ", :state => "      ").first.latitude,
  :retailer_longitude       => Retailer.where(:name => "Darlene's Boutique",:address => "14.579160, -90.471768", :city => "      ", :state => "      ").first.longitude,
  :active_flag              => 1,
  :created_at               => DateTime.now,
  :updated_at               => DateTime.now,
  :share_to_unlock_pct      => "+15%",
  :social_discount_interval => 5,
  :redemption_passphrase    => "wealking bajo la lluvia (Walking in the rain)"
)
zone = Map.which_zone?( [ deal.retailer_latitude, deal.retailer_longitude ] )
deal.update_attribute( :retailer_zone, zone ||= 0 )
puts "  Darlene's Boutique deal created"
# puts "#{dc.make_badge( deal.badge_text, deal)}"
puts "Deals Created using DealSeed"

# Billy's Heli Shop, deal_id = 11, starts with 1 offered
# ActiveRecord::Base.connection.insert("
# INSERT INTO redemptions (
#   deal_id, 
#   num_redeemed, 
#   num_available,
#   created_at,
#   updated_at) 
# VALUES (
#   (SELECT id FROM deals WHERE name = 'Align 450 Super Combo $75.00 off regular price' LIMIT 1),
#   1,
#   0,
#   curdate(),
#   curdate());")
# Redemption.create(
#   :deal_id      => Deal.where(:name => "Align 450 Super Combo $75.00 off regular price").first.id,
#   :num_redeemed => 1,
#   :num_available => 0
# )
# Now update the Deal's num_redeemed and num_available
# ActiveRecord::Base.connection.update("
#   UPDATE deals SET 
#     num_redeemed = 1, 
#     -- num_available = 0, 
#     updated_at = curdate() 
#   WHERE name = 'Align 450 Super Combo $75.00 off regular price'")
# deal = Deal.where(:name => "Align 450 Super Combo $75.00 off regular price").first
# deal.update_attribute( :num_redeemed, 1)
# deal.update_attribute( :num_available, 0)

# Fry's
# ActiveRecord::Base.connection.insert("
# INSERT INTO redemptions (deal_id, num_redeemed, num_available,created_at,updated_at) VALUES ((SELECT id FROM deals WHERE name = '20% off Western Digital 1TB Hard Drive' LIMIT 1),1,99,curdate(),curdate());")
# Redemption.create(
#   :deal_id      => Deal.where(:name => "20% off Western Digital 1TB Hard Drive").first.id,
#   :num_redeemed => 1,
#   :num_available => 99
# )
# ActiveRecord::Base.connection.update("
#   UPDATE deals SET num_redeemed = 1, num_available = 99, updated_at = curdate() WHERE name = '20% off Western Digital 1TB Hard Drive'")
# deal = Deal.where(:name => "20% off Western Digital 1TB Hard Drive").first
# deal.update_attribute( :num_redeemed, 1)
# deal.update_attribute( :num_available, 99)

# puts "Redemptions created and their Deals updated"

=begin
Advertisements are like deals in that they offer "deals" but do not require the deal to be redeemed.
Advertisements are associated with Retailers and Advertisers so that "Retailers have many advertisers through advertisements".
If an Advertisement has a retailer_id but no advertiser_id then that advertisement has been placed by the retailer itself,
not its corporate or parent entity (if one exists)
=end

AdvertisementType.create!(:advertisement_type => "Splash",              :description => "Full Screen with miinfo log at the top, clickable with underlying URL")
AdvertisementType.create!(:advertisement_type => "Featured Sponsored",  :description => "Taller Rectangular Strip mixed in with Featured Deals")
AdvertisementType.create!(:advertisement_type => "Regular Sponsored",   :description => "Shorter Rectangular Strip mixed in with Alerts")
AdvertisementType.create!(:advertisement_type => "Full Screen",         :description => "Full Screen all area is devoted to the advertisement")

# AdvertisementType.create!(:advertisement_type => "Splash",              :description => "Splash Ads are web pages that act as stylized 'doorways' to a site that provide a highly tailored message to new visitors. They are different from typical home pages in that they usually have an 'Enter' button or equivalent.")
# AdvertisementType.create!(:advertisement_type => "Featured Sponsored",  :description => "Taller Rectangular Strip - Websites that utilize Pay Per Click (PPC) ads will display an advertisement when a keyword query matches an advertiser's keyword list, or when a content site displays relevant content. Such advertisements are called sponsored links or sponsored ads, and appear adjacent to or above organic results on search engine results pages, or anywhere a web developer chooses on a content site")
# AdvertisementType.create!(:advertisement_type => "Regular Sponsored",   :description => "The in-app advertising system Apple offers to developers of iOS apps running on the iPhone, iPod touch, and iPad. The iAd system allows developers to include advertising in their apps to earn more money or subsidize free apps. The ads can offer sophisticated interactivity and animation, as well as more traditional display banner ads.")

puts "Advertisement Types created"
puts "********* Starting Advertisements ***********"
# Advertiser is distinct entity, related to the Retailer
ad = AdvertisementSeed.create!(
  :retailer_id            => Retailer.where(:name => "Walgreen's Pharmacy", :address => "Bulevar Vista Hermosa 17-30 Plaza Nahum oficina 102 Zona 15", :city => "Ciudad de Guatemala", :state => "Guatemala").first.id,
  :advertiser_id          => Advertiser.where(:name => "Walgreens's Corporate").first.id,
  :advertisement_type_id  => AdvertisementType.where(:advertisement_type => "Splash").first.id,
  :url                    => "www.google.com",
  :name                   => "99% off Select Items Sale",
  :description            => "All of our Summer clothing and flip-flops are on sale... Look for the deal in the Dallas Morning News",
  :content                => "Advertisement html or url goes here...",
  :beg_date               => "2012-02-01",
  :end_date               => "2012-04-15",
  :created_at             => DateTime.now,
  :updated_at             => DateTime.now
)
retailer = Retailer.where(:name => "Walgreen's Pharmacy", :address => "Bulevar Vista Hermosa 17-30 Plaza Nahum oficina 102 Zona 15", :city => "Ciudad de Guatemala", :state => "Guatemala").first
ad.update_attribute( :retailer_zone, Map.which_zone?( [ retailer.latitude, retailer.longitude ] ) )
puts "  Walgreen's Pharmacy Advertisement 1 created"
ad = AdvertisementSeed.create!(
  :retailer_id            => Retailer.where(:name => "Kohl's", :address => "4A Avenida, Zona 1", :city => "Ciudad de Guatemala", :state => "Guatemala").first.id,
  :advertiser_id          => Advertiser.where(:name => "Kohl's Corporate").first.id,
  :advertisement_type_id  => AdvertisementType.where(:advertisement_type => "Splash").first.id,
  :url                    => "www.google.com",
  :name                   => "33% off Select Items Sale",
  :description            => "This is the  best sale ever in the  entire world",
  :content                => "Advertisement html or url goes here...",
  :beg_date               => "2012-02-01",
  :end_date               => "2012-04-15",
  :created_at             => DateTime.now,
  :updated_at             => DateTime.now
)
retailer = Retailer.where(:name => "Kohl's", :address => "4A Avenida, Zona 1", :city => "Ciudad de Guatemala", :state => "Guatemala").first
ad.update_attribute( :retailer_zone, Map.which_zone?( [ retailer.latitude, retailer.longitude ] ) )
puts "  Kohl's Splash Advertisement created"
ad = AdvertisementSeed.create!(
  :retailer_id            => Retailer.where(:name => "Sears", :address => "Km.14.5 Carr. El Salvador C.C. Escala L.#30", :city => "Ciudad de Guatemala", :state => "Guatemala").first.id,
  :advertiser_id          => Advertiser.where(:name => "Sears Corporate").first.id,
  :advertisement_type_id  => AdvertisementType.where(:advertisement_type => "Splash").first.id,
  :url                    => "www.google.com",
  :name                   => "All Select Items Sale",
  :description            => "This is the best day in the world for bargain shoppers",
  :content                => "Advertisement html or url goes here...",
  :beg_date               => "2012-02-01",
  :end_date               => "2012-04-15",
  :created_at             => DateTime.now,
  :updated_at             => DateTime.now
)
retailer = Retailer.where(:name => "Sears", :address => "Km.14.5 Carr. El Salvador C.C. Escala L.#30", :city => "Ciudad de Guatemala", :state => "Guatemala").first
ad.update_attribute( :retailer_zone, Map.which_zone?( [ retailer.latitude, retailer.longitude ] ) )
puts "  Sears Advertisement 1 created"
# Advertiser is distinct entity, related to the Retailer
ad = AdvertisementSeed.create!(
  :retailer_id            => Retailer.where(:name => "Walgreen's Pharmacy", :address => "Bulevar Vista Hermosa 17-30 Plaza Nahum oficina 102 Zona 15", :city => "Ciudad de Guatemala", :state => "Guatemala").first.id,
  :advertiser_id          => Advertiser.where(:name => "Walgreens's Corporate").first.id,
  :advertisement_type_id  => AdvertisementType.where(:advertisement_type => "Featured Sponsored").first.id,
  :url                    => "www.google.com",
  :name                   => "Camera Batteries and Film on SALE",
  :description            => "All Camera Batteries and Film will be on sale",
  :content                => "Advertisement html or url goes here...",
  :beg_date               => "2012-02-01",
  :end_date               => "2012-04-15",
  :created_at             => DateTime.now,
  :updated_at             => DateTime.now
)
retailer = Retailer.where(:name => "Walgreen's Pharmacy", :address => "Bulevar Vista Hermosa 17-30 Plaza Nahum oficina 102 Zona 15", :city => "Ciudad de Guatemala", :state => "Guatemala").first
ad.update_attribute( :retailer_zone, Map.which_zone?( [ retailer.latitude, retailer.longitude ] ) )
puts "  Walgreen's Pharmacy Advertisement 2 created"
# Advertiser = Retailer
ad = AdvertisementSeed.create!(
  :retailer_id            => Retailer.where(:name => "Kristian's Scuba King", :address => "Ruta 3 Via 5 esquina Zona 4", :city => "Ciudad de Guatemala", :state => "Guatemala").first.id,
  :advertiser_id          => Advertiser.where(:retailer_id => Retailer.where(:name => "Kristian's Scuba King", :address => "Ruta 3 Via 5 esquina Zona 4", :city => "Ciudad de Guatemala", :state => "Guatemala").first.id).first.id,
  :advertisement_type_id  => AdvertisementType.where(:advertisement_type => "Featured Sponsored").first.id,
  :url                    => "www.google.com",
  :name                   => "All empty tanks on SALE",
  :description            => "All empty tanks will be on sale",
  :content                => "Advertisement html or url goes here...",
  :beg_date               => "2012-02-01",
  :end_date               => "2012-04-15",
  :created_at             => DateTime.now,
  :updated_at             => DateTime.now
)
retailer = Retailer.where(:name => "Kristian's Scuba King", :address => "Ruta 3 Via 5 esquina Zona 4", :city => "Ciudad de Guatemala", :state => "Guatemala").first
ad.update_attribute( :retailer_zone, Map.which_zone?( [ retailer.latitude, retailer.longitude ] ) )
puts "  Kristian's Scuba King Advertisement created"
# Advertiser = Retailer
ad = AdvertisementSeed.create!(
  :retailer_id            => Retailer.where(:name => "Darlene's Boutique", :address => "14.579160, -90.471768").first.id,
  :advertiser_id          => Advertiser.where(:retailer_id => Retailer.where(:name => "Darlene's Boutique", :address => "14.579160, -90.471768", :city => "      ", :state => "      ").first.id).first.id,
  :advertisement_type_id  => AdvertisementType.where(:advertisement_type => "Regular Sponsored").first.id,
  :url                    => "www.google.com",
  :name                   => "Floral Baskets on SALE",
  :description            => "All Floral Baskets will be on sale",
  :content                => "Advertisement html or url goes here...",
  :beg_date               => "2012-02-01",
  :end_date               => "2012-04-15",
  :created_at             => DateTime.now,
  :updated_at             => DateTime.now
)
retailer = Retailer.where(:name => "Darlene's Boutique", :address => "14.579160, -90.471768").first
ad.update_attribute( :retailer_zone, Map.which_zone?( [ retailer.latitude, retailer.longitude ] ) )
puts "  Darlene's Boutique Advertisement created"
ad = AdvertisementSeed.create!(
  :retailer_id            => Retailer.where(:name => "Sears", :address => "Km.14.5 Carr. El Salvador C.C. Escala L.#30", :city => "Ciudad de Guatemala", :state => "Guatemala").first.id,
  :advertiser_id          => Advertiser.where(:name => "Sears Corporate").first.id,
  :advertisement_type_id  => AdvertisementType.where(:advertisement_type => "Regular Sponsored").first.id,
  :url                    => "www.google.com",
  :name                   => "Table Saws and Contractor Tools 25% Off",
  :description            => "Contractors come one, come all to the big Table Saw Sale",
  :content                => "Advertisement html or url goes here...",
  :beg_date               => "2012-02-01",
  :end_date               => "2012-04-15",
  :created_at             => DateTime.now,
  :updated_at             => DateTime.now
)
retailer = Retailer.where(:name => "Sears", :address => "Km.14.5 Carr. El Salvador C.C. Escala L.#30", :city => "Ciudad de Guatemala", :state => "Guatemala").first
ad.update_attribute( :retailer_zone, Map.which_zone?( [ retailer.latitude, retailer.longitude ] ) )
puts "  Sears Advertisement 2 created"
ad = AdvertisementSeed.create!(
  :retailer_id            => Retailer.where(:name => "Darlene's Boutique", :address => "14.579160, -90.471768").first.id,
  :advertiser_id          => Advertiser.where(:retailer_id => Retailer.where(:name => "Darlene's Boutique", :address => "14.579160, -90.471768", :city => "      ", :state => "      ").first.id).first.id,
  :advertisement_type_id  => AdvertisementType.where(:advertisement_type => "Featured Sponsored").first.id,
  :url                    => "www.google.com",
  :name                   => "Designer Fragrances all ON SALE",
  :description            => "All of your favorite fragrances are on special for a limited time only!",
  :content                => "Advertisement html or url goes here...",
  :beg_date               => "2012-02-01",
  :end_date               => "2012-04-15",
  :created_at             => DateTime.now,
  :updated_at             => DateTime.now
)
retailer = Retailer.where(:name => "Darlene's Boutique", :address => "14.579160, -90.471768").first
ad.update_attribute( :retailer_zone, Map.which_zone?( [ retailer.latitude, retailer.longitude ] ) )
puts "  Darlene's Boutique Featured Advertisement created"
ad = AdvertisementSeed.create!(
  :retailer_id            => Retailer.where(:name => "Kohl's", :address => "4A Avenida, Zona 1", :city => "Ciudad de Guatemala", :state => "Guatemala").first.id,
  :advertiser_id          => Advertiser.where(:name => "Kohl's Corporate").first.id,
  :advertisement_type_id  => AdvertisementType.where(:advertisement_type => "Regular Sponsored").first.id,
  :url                    => "www.google.com",
  :name                   => "Kitchen Accessories 40% Off",
  :description            => "This is the  best Kitchen Accessories Sale ever in the history of the entire world",
  :content                => "Advertisement html or url goes here...",
  :beg_date               => "2012-02-01",
  :end_date               => "2012-04-15",
  :created_at             => DateTime.now,
  :updated_at             => DateTime.now
)
retailer = Retailer.where(:name => "Kohl's", :address => "4A Avenida, Zona 1", :city => "Ciudad de Guatemala", :state => "Guatemala").first
ad.update_attribute( :retailer_zone, Map.which_zone?( [ retailer.latitude, retailer.longitude ] ) )
puts "  Kohl's Regular Sponsored Advertisement created"

=begin
# Retailer = Advertiser
Advertiser.create!(
  :advertiser_type_id => AdvertiserType.where(:advertiser_type => "physical").first.id,
  :retailer_id        => Retailer.where(:name => "Kristian's Scuba King", :address => "411 Buckingham Rd").first.id
)
# Retailer = Advertiser
Advertiser.create!(
  :advertiser_type_id => AdvertiserType.where(:advertiser_type => "physical").first.id,
  :retailer_id        => Retailer.where(:name => "Darlene's Boutique", :address => "5000 Greenville Av").first.id
)
=end
puts "Advertisements created using AdvertisementSeed"

# Create the CompassPoint recs
CompassPoint.create!(:name => "Inbound",  :description => "Inbound into the city") 
CompassPoint.create!(:name => "Outbound", :description => "Outbound from the city")
CompassPoint.create!(:name => "N",        :description => "North") 
CompassPoint.create!(:name => "NNE",      :description => "North Northeast") 
CompassPoint.create!(:name => "NE",       :description => "Northeast") 
CompassPoint.create!(:name => "ENE",      :description => "East Northeast") 
CompassPoint.create!(:name => "E",        :description => "East") 
CompassPoint.create!(:name => "ESE",      :description => "East Southeast") 
CompassPoint.create!(:name => "SE",       :description => "Southeast") 
CompassPoint.create!(:name => "SSE",      :description => "South Southeast") 
CompassPoint.create!(:name => "S",        :description => "South") 
CompassPoint.create!(:name => "SSW",      :description => "South Southwest") 
CompassPoint.create!(:name => "SW",       :description => "Southwest") 
CompassPoint.create!(:name => "WSW",      :description => "West Southwest") 
CompassPoint.create!(:name => "W",        :description => "West") 
CompassPoint.create!(:name => "WNW",      :description => "West Northwest") 
CompassPoint.create!(:name => "NW",       :description => "Northwest") 
CompassPoint.create!(:name => "NNW",      :description => "North Northwest") 

puts "Compass Points created"

=begin
central expressway intersection haskell ave dallas, tx
central expressway intersection fitzhugh ave dallas, tx
central expressway intersection knox st dallas, tx
central expressway intersection mockingbird ln dallas, tx
central expressway intersection lovers ln dallas, tx
central expressway intersection northwest hwy dallas, tx
central expressway intersection park ln dallas, tx
central expressway intersection walnut hill ln dallas, tx
central expressway intersection royal ln dallas, tx
central expressway intersection forest ln dallas, tx
=end

# Creating Traffic Cameras
# NOTE: The "Other" traffic_camera record is for traffic alerts coming from a source Other Than an actual traffic camera.  This may be an eyewitness report, a tweet, etc

# TrafficCamera.create!( :name => "Other", :address => "9666 Whitehurst Dr Dallas, TX, 75243", :status => 1, :geocode_flag => 1, :url => "www.sensr.com" )
# NOTE: Inbound refers to the camera LOOKING IN the Inbound traffic direction, so if Inbound is South, the camera is pointing South
=begin
Original cams
1 - TrafficCameraSeed.create!( :name => "Central & Haskell Looking Inbound",  :address => "central expressway intersection haskell ave dallas, tx", :url => "www.sensr.com/cam1a.com", :status => 1, :geocode_flag => 1, :compass_point_id => CompassPoint.where(:name => "Inbound").first.id )
2 - TrafficCameraSeed.create!( :name => "Central & Haskell Looking Outbound", :address => "central expressway intersection haskell ave dallas, tx", :url => "www.sensr.com/cam1b.com", :status => 1, :geocode_flag => 1, :compass_point_id => CompassPoint.where(:name => "Outbound").first.id )

3 - TrafficCameraSeed.create!( :name => "Central & Fitzhugh Looking Inbound",  :address => "central expressway intersection fitzhugh ave dallas, tx", :url => "www.sensr.com/cam2a.com", :status => 1, :geocode_flag => 1, :compass_point_id => CompassPoint.where(:name => "Inbound").first.id  )
4 - TrafficCameraSeed.create!( :name => "Central & Fitzhugh Looking Outbound", :address => "central expressway intersection fitzhugh ave dallas, tx", :url => "www.sensr.com/cam2b.com", :status => 1, :geocode_flag => 1, :compass_point_id => CompassPoint.where(:name => "Outbound").first.id )

5 - TrafficCameraSeed.create!( :name => "Central & Knox Looking Inbound",  :address => "central expressway intersection knox st dallas, tx", :url => "www.sensr.com/cam3a.com", :status => 1, :geocode_flag => 1, :compass_point_id => CompassPoint.where(:name => "Inbound").first.id  )
6 - TrafficCameraSeed.create!( :name => "Central & Knox Looking Outbound", :address => "central expressway intersection knox st dallas, tx", :url => "www.sensr.com/cam3b.com", :status => 1, :geocode_flag => 1, :compass_point_id => CompassPoint.where(:name => "Outbound").first.id )

7 - TrafficCameraSeed.create!( :name => "Central & Mockingbird Looking Inbound",  :address => "central expressway intersection mockingbird ln dallas, tx", :url => "www.sensr.com/cam4a.com", :status => 1, :geocode_flag => 1, :compass_point_id => CompassPoint.where(:name => "Inbound").first.id  )
8 - TrafficCameraSeed.create!( :name => "Central & Mockingbird Looking Outbound", :address => "central expressway intersection mockingbird ln dallas, tx", :url => "www.sensr.com/cam4b.com", :status => 1, :geocode_flag => 1, :compass_point_id => CompassPoint.where(:name => "Outbound").first.id )
=end
=begin
1 - Calzada Roosevelt @ 39 Avenida, Ciudad de Guatemala, Guatemala => [14.633355,-90.570323] Inbound
2 - Calzada Roosevelt @ 19 Avenida, Ciudad de Guatemala, Guatemala => [14.622039,-90.549488] Outbound
3 - Boulevar Los Proceres @ 3A Avenida, Ciudad de Guatemala, Guatemala => [14.593863,-90.514673] Inbound
4 - Carretara Al Salvador @ 4A Avenida, Ciudad de Guatemala, Guatemala => [14.598597,-90.523932] Outbound
5 - 5a Calle @ 7A Avenida, Ciudad de Guatemala, Guatemala => [14.650098,-90.495082 Inbound
6 - 5a Calle @ 20 Avenida, Ciudad de Guatemala, Guatemala => [14.650244,-90.493709] Outbound
7 - 8a Calle @ 13 Avenida, Ciudad de Guatemala, Guatemala => [14.645926,-90.537295] Inbound
8 - Avenida Bolivar @ Calzada Roosevelt, Ciudad de Guatemala, Guatemala => [14.614191,-90.534425] Outbound
=end
# New GT cams
TrafficCameraSeed.create!( 
  :name => "Calzada Roosevelt @ 39 Avenida",  
  :address => "14.633355,-90.570323", 
  :latitude => 14.633355,
  :longitude => -90.570323,
  :url => "www.sensr.com/cam1a.com", 
  :status => 1, :geocode_flag => 1, 
  :compass_point_id => CompassPoint.where(:name => "Inbound").first.id )
TrafficCameraSeed.create!( 
  :name => "Calzada Roosevelt @ 19 Avenida", 
  :address => "14.622039,-90.549488", 
  :latitude => 14.622039,
  :longitude => -90.549488,
  :url => "www.sensr.com/cam1b.com", 
  :status => 1, 
  :geocode_flag => 1, 
  :compass_point_id => CompassPoint.where(:name => "Outbound").first.id )
TrafficCameraSeed.create!( 
  :name => "Boulevar Los Proceres @ 3A Avenida",  
  :address => "14.593863,-90.514673", 
  :url => "www.sensr.com/cam2a.com", 
  :latitude => 14.593863,
  :longitude => -90.514673,
  :status => 1, 
  :geocode_flag => 1, 
  :compass_point_id => CompassPoint.where(:name => "Inbound").first.id  )
TrafficCameraSeed.create!( 
  :name => "Carretara Al Salvador @ 4A Avenida", 
  :address => "14.598597,-90.523932", 
  :url => "www.sensr.com/cam2b.com", 
  :latitude => 14.598597,
  :longitude => -90.523932,
  :status => 1, 
  :geocode_flag => 1, 
  :compass_point_id => CompassPoint.where(:name => "Outbound").first.id )
TrafficCameraSeed.create!( 
  :name => "5a Calle @ 7A Avenida",  
  :address => "14.652122,-90.511036", 
  # :name => "5a Calle @ 19 Avenida",  
  # :address => "14.650098,-90.495082", 
  :url => "www.sensr.com/cam3a.com", 
  :latitude => 14.652122,
  :longitude => -90.511036,
  :status => 1, 
  :geocode_flag => 1, 
  :compass_point_id => CompassPoint.where(:name => "Inbound").first.id  )
TrafficCameraSeed.create!( 
  :name => "5a Calle @ 20 Avenida", 
  :address => "14.650244,-90.493709", 
  :url => "www.sensr.com/cam3b.com", 
  :latitude => 14.650244,
  :longitude => -90.493709,
  :status => 1, 
  :geocode_flag => 1, 
  :compass_point_id => CompassPoint.where(:name => "Outbound").first.id )
TrafficCameraSeed.create!( 
  :name => "8a Calle @ 13 Avenida",  
  :address => "14.645926,-90.537295", 
  :url => "www.sensr.com/cam4a.com", 
  :latitude => 14.645926,
  :longitude => -90.537295,
  :status => 1, 
  :geocode_flag => 1, 
  :compass_point_id => CompassPoint.where(:name => "Inbound").first.id  )
TrafficCameraSeed.create!( 
  :name => "Avenida Bolivar @ Calzada Roosevelt", 
  :address => "14.614191,-90.534425", 
  :url => "www.sensr.com/cam4b.com", 
  :latitude => 14.614191,
  :longitude => -90.534425,
  :status => 1, 
  :geocode_flag => 1, 
  :compass_point_id => CompassPoint.where(:name => "Outbound").first.id )

puts "Traffic Cameras Created using TrafficCameraSeed"

TrafficRating.create!( :rating => "1",  :description => "Excellent", :icon_path => "app/assets/images/excellent.jpg" )
TrafficRating.create!( :rating => "2",  :description => "Good",      :icon_path => "app/assets/images/good.jpg" )
TrafficRating.create!( :rating => "3",  :description => "Fair",      :icon_path => "app/assets/images/fair.jpg" )
TrafficRating.create!( :rating => "4",  :description => "Poor",      :icon_path => "app/assets/images/poor.jpg" )
TrafficRating.create!( :rating => "5",  :description => "Stopped",   :icon_path => "app/assets/images/stopped.jpg" )

puts "Traffic Ratings Created"

# create traffic_data_types recs:
TrafficDataType.create!(:name => "LiveCam",      :description => "Live Traffic Camera Analysis")
TrafficDataType.create!(:name => "Historical",   :description => "Interpolated from Historical Norms")
TrafficDataType.create!(:name => "Other:Tweet",  :description => "Eyewitness tweeted in")
TrafficDataType.create!(:name => "Other:Email",  :description => "Eyewitness emailed in")
TrafficDataType.create!(:name => "Other:Phone",  :description => "Eyewitness phoned in")
TrafficDataType.create!(:name => "Other:Other",  :description => "Miscellaneous source")

puts "Traffic Data Types Created"

=begin
                                      TrafficDataType id values vs. Field Input Requirements
                                      
  R = Required; N = Not Required

  traffic_data_type_id    traffic_camera_id   other_source    other_address   other_description   other_latitude    other_longitude
  --------------------    -----------------   ------------    -------------   -----------         --------------    ---------------
  "LiveCam"      (1)            R                 N               N               N
  "Historical"   (2)            R                 N               N               N
                          ___________________________________________________________________________________________________
  "Other:Tweet"  (3)                                                                            lat/long will be geocoded 
  "Other:Email"  (4)            N                 N               R               R             using "other_address" which is
  "Other:Phone"  (5)                                                                            required for these values
                          ___________________________________________________________________________________________________
  "Other:Other"  (6)            N                 R               R               R
  
  CompassPoint data:
  id    Name
  --  ---------
  1   "Inbound"
  2   "Outbound"
  
  #{get_date}
=end

def get_date
  Time.now.strftime("%Y-%m-%d")
end

# Create traffic conditions (alerts)
excl = TrafficRating.where(:rating => "1").first.id
good = TrafficRating.where(:rating => "2").first.id
fair = TrafficRating.where(:rating => "3").first.id
poor = TrafficRating.where(:rating => "4").first.id
stop = TrafficRating.where(:rating => "5").first.id

live = TrafficDataType.where(:name => "LiveCam").first.id
twee = TrafficDataType.where(:name => "Other:Tweet").first.id
emai = TrafficDataType.where(:name => "Other:Email").first.id
phon = TrafficDataType.where(:name => "Other:Phone").first.id
othe = TrafficDataType.where(:name => "Other:Other").first.id

# to update these to today's date: UPDATE traffic_conditions SET report_date = CONCAT(CURDATE(), ' ', time(report_date));
# Report from a LiveCam
cam_id1 = TrafficCamera.where(:name => "Calzada Roosevelt @ 39 Avenida").first.id
cam_id2 = TrafficCamera.where(:name => "Calzada Roosevelt @ 19 Avenida").first.id
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => excl, :compass_point_id => 1, :report_date => "#{get_date} 07:45:48 AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => good, :compass_point_id => 1, :report_date => "#{get_date} 07:59:11 AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => excl, :compass_point_id => 1, :report_date => "#{get_date} 08:15:08 AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => excl, :compass_point_id => 1, :report_date => "#{get_date} 08:25:02 AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => good, :compass_point_id => 1, :report_date => "#{get_date} 08:31:01 AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => excl, :compass_point_id => 1, :report_date => "#{get_date} 08:45:08 AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => good, :compass_point_id => 1, :report_date => "#{get_date} 08:59:00 AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => poor, :compass_point_id => 1, :report_date => "#{get_date} 09:29:03 AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => poor, :compass_point_id => 1, :report_date => "#{get_date} 09:46:33 AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "#{get_date} 10:01:14 AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "#{get_date} 10:15:15 AM")
puts "............... 1"
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => poor, :compass_point_id => 1, :report_date => "#{get_date} 12:17:03 AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => poor, :compass_point_id => 1, :report_date => "#{get_date} 12:29:33 AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "#{get_date} 12:44:14 AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "#{get_date} 12:59:15 AM")
# cam_id = 2
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => poor, :compass_point_id => 2, :report_date => "#{get_date} 08:45:15 AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => poor, :compass_point_id => 2, :report_date => "#{get_date} 08:59:07 AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "#{get_date} 09:15:09 AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => fair, :compass_point_id => 2, :report_date => "#{get_date} 09:29:12 AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "#{get_date} 09:46:40 AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "#{get_date} 10:00:40 AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "#{get_date} 10:15:09 AM")
puts "............... 2"
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => fair, :compass_point_id => 2, :report_date => "#{get_date} 11:16:12 AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => fair, :compass_point_id => 2, :report_date => "#{get_date} 11:36:18 AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "#{get_date} 11:46:40 AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "#{get_date} 11:59:40 AM")

TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => fair, :compass_point_id => 2, :report_date => "#{get_date} 12:16:12 PM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => fair, :compass_point_id => 2, :report_date => "#{get_date} 12:36:18 PM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "#{get_date} 12:46:40 PM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "#{get_date} 12:59:40 PM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "#{get_date} 01:04:44 PM")

TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => fair, :compass_point_id => 2, :report_date => "#{get_date} 11:16:13 AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => fair, :compass_point_id => 2, :report_date => "#{get_date} 11:36:19 AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "#{get_date} 11:46:41 AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "#{get_date} 11:59:41 AM")
"............... 3"
# report_dates out of order
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "#{get_date} 01:06:13 PM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "#{get_date} 01:05:29 PM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => fair, :compass_point_id => 2, :report_date => "#{get_date} 01:15:32 PM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => poor, :compass_point_id => 2, :report_date => "#{get_date} 01:21:09 PM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => excl, :compass_point_id => 2, :report_date => "#{get_date} 01:35:09 PM")

TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => poor, :compass_point_id => 2, :report_date => "#{get_date} 03:03:07 PM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "#{get_date} 04:15:09 PM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => fair, :compass_point_id => 2, :report_date => "#{get_date} 04:29:12 PM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "#{get_date} 04:46:40 PM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "#{get_date} 05:00:40 PM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "#{get_date} 05:15:09 PM")
"............... 4"
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => poor, :compass_point_id => 2, :report_date => "#{get_date} 02:09:18 PM", :alert_message => "car accident")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => poor, :compass_point_id => 2, :report_date => "#{get_date} 02:16:22 PM", :alert_message => "car accident")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "#{get_date} 02:21:23 PM", :alert_message => "accident cleared")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => fair, :compass_point_id => 2, :report_date => "#{get_date} 02:29:52 PM", :alert_message => "brief slowdown")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "#{get_date} 02:46:49 PM", :alert_message => "running well")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => poor, :compass_point_id => 2, :report_date => "#{get_date} 02:49:15 PM", :alert_message => "construction delay")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "#{get_date} 02:55:55 PM", :alert_message => "running well")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "#{get_date} 03:05:05 PM", :alert_message => "running well")
"............... 5"
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => poor, :compass_point_id => 2, :report_date => "#{get_date} 03:21:12 PM", :alert_message => "car accident")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => poor, :compass_point_id => 2, :report_date => "#{get_date} 03:32:32 PM", :alert_message => "car accident")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "#{get_date} 03:46:40 PM", :alert_message => "accident cleared")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => fair, :compass_point_id => 2, :report_date => "#{get_date} 03:55:59 PM", :alert_message => "brief slowdown")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "#{get_date} 04:06:09 PM", :alert_message => "running well")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => poor, :compass_point_id => 2, :report_date => "#{get_date} 04:15:15 PM", :alert_message => "construction delay")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "#{get_date} 04:29:55 PM", :alert_message => "running well")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "#{get_date} 04:43:01 PM", :alert_message => "running well")
"............... 6"
puts "****** cam_id2 Traffic Conditions Completed"
# ***********************

# Report from a mix of LiveCams and "Other*" values
cam_id3 = TrafficCamera.where(:name => "Boulevar Los Proceres @ 3A Avenida").first.id
cam_id4 = TrafficCamera.where(:name => "Carretara Al Salvador @ 4A Avenida").first.id
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id3, :traffic_rating_id => excl, :compass_point_id => 1, :report_date => "#{get_date} 08:44:03AM")
TrafficCondition.create!(:traffic_data_type_id => twee, :traffic_camera_id => nil,     :traffic_rating_id => good, :compass_point_id => 1, :report_date => "#{get_date} 08:58:12AM", :other_source => nil, :other_address => "central expressway intersection fitzhugh ave dallas, tx", :other_description => "There's a dead skunk by the side of the road, and it's stinking to high, high heaven", :other_latitude => "32.815606", :other_longitude => "-96.788988")
TrafficCondition.create!(:traffic_data_type_id => twee, :traffic_camera_id => nil,     :traffic_rating_id => poor, :compass_point_id => 1, :report_date => "#{get_date} 09:16:05AM", :other_source => nil, :other_address => "central expressway intersection fitzhugh ave dallas, tx", :other_description => "Car stopped side of the road, onlooker slowdown", :other_latitude => "32.815606", :other_longitude => "-96.788988")
TrafficCondition.create!(:traffic_data_type_id => emai, :traffic_camera_id => nil,     :traffic_rating_id => stop, :compass_point_id => 1, :report_date => "#{get_date} 09:30:03AM", :other_source => nil, :other_address => "central expressway intersection fitzhugh ave dallas, tx", :other_description => "Tow truck putting car on the back on the far side", :other_latitude => "32.815606", :other_longitude => "-96.788988")
TrafficCondition.create!(:traffic_data_type_id => phon, :traffic_camera_id => nil,     :traffic_rating_id => excl, :compass_point_id => 1, :report_date => "#{get_date} 09:45:23AM", :other_source => nil, :other_address => "central expressway intersection fitzhugh ave dallas, tx", :other_description => "Rear End collision between truck and car in the traffic slowdown", :other_latitude => "32.815606", :other_longitude => "-96.788988")
puts "****** cam_id3 Traffic Conditions Completed"

TrafficCondition.create!(:traffic_data_type_id => othe, :traffic_camera_id => nil,     :traffic_rating_id => stop, :compass_point_id => 2, :report_date => "#{get_date} 08:44:09AM", :other_source => "Facebook IM to our wall", :other_address => "central expressway intersection fitzhugh ave dallas, tx", :other_description => "Rear End collision between truck and car in the traffic slowdown", :other_latitude => "32.815606", :other_longitude => "-96.788988")
TrafficCondition.create!(:traffic_data_type_id => othe, :traffic_camera_id => nil,     :traffic_rating_id => good, :compass_point_id => 2, :report_date => "#{get_date} 08:58:07AM", :other_source => "Facebook IM to our wall", :other_address => "central expressway intersection fitzhugh ave dallas, tx", :other_description => "Pedestrian struck", :other_latitude => "32.815606", :other_longitude => "-96.788988")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id4, :traffic_rating_id => fair, :compass_point_id => 2, :report_date => "#{get_date} 09:16:01AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id4, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "#{get_date} 09:29:15AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id4, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "#{get_date} 09:45:31AM")
puts "****** cam_id4 Traffic Conditions Completed"
# ***********************
# Try some different compass points other than "Inbound" and "Outbound"
cam_id5 = TrafficCamera.where(:name => "5a Calle @ 7A Avenida").first.id
cam_id6 = TrafficCamera.where(:name => "5a Calle @ 20 Avenida").first.id
s = CompassPoint.where(:name => "S").first.id
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id5, :traffic_rating_id => excl, :compass_point_id => s, :report_date => "#{get_date} 08:44:03AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id5, :traffic_rating_id => excl, :compass_point_id => s, :report_date => "#{get_date} 08:58:12AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id5, :traffic_rating_id => excl, :compass_point_id => s, :report_date => "#{get_date} 09:16:05AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id5, :traffic_rating_id => excl, :compass_point_id => s, :report_date => "#{get_date} 09:30:03AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id5, :traffic_rating_id => excl, :compass_point_id => s, :report_date => "#{get_date} 09:45:23AM")
puts "****** cam_id5 Traffic Conditions Completed"
n = CompassPoint.where(:name => "N").first.id
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id6, :traffic_rating_id => excl, :compass_point_id => n, :report_date => "#{get_date} 08:44:09AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id6, :traffic_rating_id => excl, :compass_point_id => n, :report_date => "#{get_date} 08:58:07AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id6, :traffic_rating_id => good, :compass_point_id => n, :report_date => "#{get_date} 09:16:01AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id6, :traffic_rating_id => fair, :compass_point_id => n, :report_date => "#{get_date} 09:29:15AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id6, :traffic_rating_id => poor, :compass_point_id => n, :report_date => "#{get_date} 09:45:31AM")
puts "****** cam_id6 Traffic Conditions Completed"
# ***********************
cam_id7 = TrafficCamera.where(:name => "8a Calle @ 13 Avenida").first.id
cam_id8 = TrafficCamera.where(:name => "Avenida Bolivar @ Calzada Roosevelt").first.id
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id7, :traffic_rating_id => excl, :compass_point_id => 1, :report_date => "#{get_date} 08:46:03AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id7, :traffic_rating_id => excl, :compass_point_id => 1, :report_date => "#{get_date} 09:00:12AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id7, :traffic_rating_id => good, :compass_point_id => 1, :report_date => "#{get_date} 09:18:05AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id7, :traffic_rating_id => good, :compass_point_id => 1, :report_date => "#{get_date} 09:32:03AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id7, :traffic_rating_id => good, :compass_point_id => 1, :report_date => "#{get_date} 09:47:23AM")
puts "****** cam_id7 Traffic Conditions Completed"
                                                                                                                   
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id8, :traffic_rating_id => excl, :compass_point_id => 2, :report_date => "#{get_date} 08:46:09AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id8, :traffic_rating_id => excl, :compass_point_id => 2, :report_date => "#{get_date} 09:00:17AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id8, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "#{get_date} 09:18:01AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id8, :traffic_rating_id => fair, :compass_point_id => 2, :report_date => "#{get_date} 09:31:15AM")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id8, :traffic_rating_id => excl, :compass_point_id => 2, :report_date => "#{get_date} 09:47:31AM")
puts "****** cam_id8 Traffic Conditions Completed"


=begin
# ***********************
cam_id1 = TrafficCamera.where(:name => "Central & Lovers Looking Inbound").first.id
cam_id2 = TrafficCamera.where(:name => "Central & Lovers Looking Outbound").first.id
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => excl, :compass_point_id => 1, :report_date => "2012-01-13 18:48:03")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => good, :compass_point_id => 1, :report_date => "2012-01-13 07:02:12")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => fair, :compass_point_id => 1, :report_date => "2012-01-13 19:20:05")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => excl, :compass_point_id => 1, :report_date => "2012-01-13 19:34:03")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => excl, :compass_point_id => 1, :report_date => "2012-01-13 19:49:23")
                                                                                                                   
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => excl, :compass_point_id => 2, :report_date => "2012-01-13 18:48:09")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => excl, :compass_point_id => 2, :report_date => "2012-01-13 19:02:17")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => excl, :compass_point_id => 2, :report_date => "2012-01-13 19:20:01")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "2012-01-13 19:33:15")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => fair, :compass_point_id => 2, :report_date => "2012-01-13 19:49:31")
# ***********************
cam_id1 = TrafficCamera.where(:name => "Central & NW Hwy Looking Inbound").first.id
cam_id2 = TrafficCamera.where(:name => "Central & NW Hwy Looking Outbound").first.id
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => good, :compass_point_id => 1, :report_date => "2012-01-13 18:51:03")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => good, :compass_point_id => 1, :report_date => "2012-01-13 19:05:12")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => fair, :compass_point_id => 1, :report_date => "2012-01-13 19:23:05")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => excl, :compass_point_id => 1, :report_date => "2012-01-13 19:37:03")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => excl, :compass_point_id => 1, :report_date => "2012-01-13 19:52:23")
                                                                                                                   
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => excl, :compass_point_id => 2, :report_date => "2012-01-13 18:51:09")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => excl, :compass_point_id => 2, :report_date => "2012-01-13 19:05:17")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "2012-01-13 19:22:01")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "2012-01-13 19:35:15")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => fair, :compass_point_id => 2, :report_date => "2012-01-13 19:51:31")
# ***********************
cam_id1 = TrafficCamera.where(:name => "Central & Park Ln Looking Inbound").first.id
cam_id2 = TrafficCamera.where(:name => "Central & Park Ln Looking Outbound").first.id
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => excl, :compass_point_id => 1, :report_date => "2012-01-13 18:54:03")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => good, :compass_point_id => 1, :report_date => "2012-01-13 19:09:12")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => good, :compass_point_id => 1, :report_date => "2012-01-13 19:27:05")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => fair, :compass_point_id => 1, :report_date => "2012-01-13 19:42:03")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => excl, :compass_point_id => 1, :report_date => "2012-01-13 19:58:23")
                                                                                                                   
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => excl, :compass_point_id => 2, :report_date => "2012-01-13 18:55:09")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => excl, :compass_point_id => 2, :report_date => "2012-01-13 19:10:17")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => excl, :compass_point_id => 2, :report_date => "2012-01-13 19:26:01")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "2012-01-13 19:39:15")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => fair, :compass_point_id => 2, :report_date => "2012-01-13 19:54:31")
# ***********************
cam_id1 = TrafficCamera.where(:name => "Central & Walnut Hill Looking Inbound").first.id
cam_id2 = TrafficCamera.where(:name => "Central & Walnut Hill Looking Outbound").first.id
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => excl, :compass_point_id => 1, :report_date => "2012-01-13 18:56:03")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => good, :compass_point_id => 1, :report_date => "2012-01-13 19:11:12")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => fair, :compass_point_id => 1, :report_date => "2012-01-13 19:29:05")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => excl, :compass_point_id => 1, :report_date => "2012-01-13 19:44:03")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => excl, :compass_point_id => 1, :report_date => "2012-01-13 19:59:23")
                                                                                                                   
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => excl, :compass_point_id => 2, :report_date => "2012-01-13 18:56:09")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => excl, :compass_point_id => 2, :report_date => "2012-01-13 18:56:09")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => excl, :compass_point_id => 2, :report_date => "2012-01-13 19:13:17")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "2012-01-13 19:29:01")
TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => fair, :compass_point_id => 2, :report_date => "2012-01-13 19:43:15")
# ***********************
=end
puts "Traffic Conditions Created"

puts "Starting Traffic Conditions Historicals"

# cam_id1 = TrafficCamera.where(:name => "Central & Haskell Looking Inbound").first.id
# cam_id2 = TrafficCamera.where(:name => "Central & Haskell Looking Outbound").first.id
# cam_id3 = TrafficCamera.where(:name => "Central & Fitzhugh Looking Inbound").first.id
# cam_id4 = TrafficCamera.where(:name => "Central & Fitzhugh Looking Outbound").first.id
# cam_id5 = TrafficCamera.where(:name => "Central & Knox Looking Inbound").first.id
# cam_id6 = TrafficCamera.where(:name => "Central & Knox Looking Outbound").first.id
# cam_id7 = TrafficCamera.where(:name => "Central & Mockingbird Looking Inbound").first.id
# cam_id8 = TrafficCamera.where(:name => "Central & Mockingbird Looking Outbound").first.id

[1,2,3,4,5,6,7,8].each do |cam_id|
  TrafficConditionHistorical::DaysOfWeek.each do |day|
    TrafficConditionHistorical::HoursOfDay.each do |time|
      # puts "cam: #{cam_id}, day: #{day[1]}, time: #{time[1]}"
      # create the recs here
      TrafficConditionHistorical.create!(:traffic_camera_id => cam_id, :traffic_rating_id => ( 1 + rand(5) ), :day_of_week => day[1], :time_of_day => time[1])
    end
    puts "Day #{day[1]} for Traffic Camera #{cam_id} completed"
  end
  puts "************************* Traffic Camera #{cam_id} completed"
end
  
# TrafficConditionHistorical.create!(:traffic_camera_id => cam_id1, :traffic_rating_id => excl, :compass_point_id => 1, :report_date => "2012-01-13 18:45:08")
# TrafficConditionHistorical.create!(:traffic_camera_id => cam_id1, :traffic_rating_id => good, :compass_point_id => 1, :report_date => "2012-01-13 18:59:00")
# TrafficConditionHistorical.create!(:traffic_camera_id => cam_id1, :traffic_rating_id => good, :compass_point_id => 1, :report_date => "2012-01-13 19:15:02")
# TrafficConditionHistorical.create!(:traffic_camera_id => cam_id1, :traffic_rating_id => poor, :compass_point_id => 1, :report_date => "2012-01-13 19:29:03")
# TrafficConditionHistorical.create!(:traffic_camera_id => cam_id1, :traffic_rating_id => poor, :compass_point_id => 1, :report_date => "2012-01-13 19:46:33")
# 
# TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => poor, :compass_point_id => 2, :report_date => "2012-01-13 18:45:15")
# TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => poor, :compass_point_id => 2, :report_date => "2012-01-13 18:59:07")
# TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "2012-01-13 19:15:09")
# TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => fair, :compass_point_id => 2, :report_date => "2012-01-13 19:29:12")
# TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "2012-01-13 19:46:40")
# # ***********************

# # Report from a mix of LiveCams and "Other*" values
# TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => excl, :compass_point_id => 1, :report_date => "2012-01-13 18:44:03")
# TrafficCondition.create!(:traffic_data_type_id => extr, :traffic_camera_id => cam_id1, :traffic_rating_id => good, :compass_point_id => 1, :report_date => "2012-01-13 18:58:12")
# TrafficCondition.create!(:traffic_data_type_id => twee, :traffic_camera_id => nil,     :traffic_rating_id => poor, :compass_point_id => 1, :report_date => "2012-01-13 19:16:05", :other_source => nil, :other_address => "central expressway intersection fitzhugh ave dallas, tx", :other_description => "Car stopped side of the road, onlooker slowdown", :other_latitude => "32.815606", :other_longitude => "-96.788988")
# TrafficCondition.create!(:traffic_data_type_id => emai, :traffic_camera_id => nil,     :traffic_rating_id => stop, :compass_point_id => 1, :report_date => "2012-01-13 19:30:03", :other_source => nil, :other_address => "central expressway intersection fitzhugh ave dallas, tx", :other_description => "Tow truck putting car on the back on the far side", :other_latitude => "32.815606", :other_longitude => "-96.788988")
# TrafficCondition.create!(:traffic_data_type_id => phon, :traffic_camera_id => nil,     :traffic_rating_id => excl, :compass_point_id => 1, :report_date => "2012-01-13 19:45:23", :other_source => nil, :other_address => "central expressway intersection fitzhugh ave dallas, tx", :other_description => "Rear End collision between truck and car in the traffic slowdown", :other_latitude => "32.815606", :other_longitude => "-96.788988")
# 
# TrafficCondition.create!(:traffic_data_type_id => othe, :traffic_camera_id => nil,     :traffic_rating_id => stop, :compass_point_id => 2, :report_date => "2012-01-13 18:44:09", :other_source => "Facebook IM to our wall", :other_address => "central expressway intersection fitzhugh ave dallas, tx", :other_description => "Rear End collision between truck and car in the traffic slowdown", :other_latitude => "32.815606", :other_longitude => "-96.788988")
# TrafficCondition.create!(:traffic_data_type_id => othe, :traffic_camera_id => nil,     :traffic_rating_id => good, :compass_point_id => 2, :report_date => "2012-01-13 18:58:07", :other_source => "Facebook IM to our wall", :other_address => "central expressway intersection fitzhugh ave dallas, tx", :other_description => "Pedestrian struck", :other_latitude => "32.815606", :other_longitude => "-96.788988")
# TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => fair, :compass_point_id => 2, :report_date => "2012-01-13 19:16:01")
# TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "2012-01-13 19:29:15")
# TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "2012-01-13 19:45:31")
# # ***********************

# # Try some different compass points other than "Inbound" and "Outbound"
# d = CompassPoint.where(:name => "S").first.id
# TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => excl, :compass_point_id => d, :report_date => "2012-01-13 18:44:03")
# TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => excl, :compass_point_id => d, :report_date => "2012-01-13 18:58:12")
# TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => excl, :compass_point_id => d, :report_date => "2012-01-13 19:16:05")
# TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => excl, :compass_point_id => d, :report_date => "2012-01-13 19:30:03")
# TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => excl, :compass_point_id => d, :report_date => "2012-01-13 19:45:23")
# d = CompassPoint.where(:name => "N").first.id
# TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => excl, :compass_point_id => d, :report_date => "2012-01-13 18:44:09")
# TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => excl, :compass_point_id => d, :report_date => "2012-01-13 18:58:07")
# TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => good, :compass_point_id => d, :report_date => "2012-01-13 19:16:01")
# TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => fair, :compass_point_id => d, :report_date => "2012-01-13 19:29:15")
# TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => poor, :compass_point_id => d, :report_date => "2012-01-13 19:45:31")
# # ***********************

# TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => excl, :compass_point_id => 1, :report_date => "2012-01-13 18:46:03")
# TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => excl, :compass_point_id => 1, :report_date => "2012-01-13 19:00:12")
# TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => good, :compass_point_id => 1, :report_date => "2012-01-13 19:18:05")
# TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => good, :compass_point_id => 1, :report_date => "2012-01-13 19:32:03")
# TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id1, :traffic_rating_id => good, :compass_point_id => 1, :report_date => "2012-01-13 19:47:23")
#                                                                                                                    
# TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => excl, :compass_point_id => 2, :report_date => "2012-01-13 18:46:09")
# TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => excl, :compass_point_id => 2, :report_date => "2012-01-13 19:00:17")
# TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => good, :compass_point_id => 2, :report_date => "2012-01-13 19:18:01")
# TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => fair, :compass_point_id => 2, :report_date => "2012-01-13 19:31:15")
# TrafficCondition.create!(:traffic_data_type_id => live, :traffic_camera_id => cam_id2, :traffic_rating_id => excl, :compass_point_id => 2, :report_date => "2012-01-13 19:47:31")
# 
# puts "Traffic Conditions Historical Created"

puts "********************************** Job Completed **********************************"

=begin
Original US Accounts
Account.create!( 
  :name           => "Victoria Admin Account",
  :address        => "1301 Hwy 191",
  :city           => "Richardson",
  :state          => "TX",
  :zip            => "75080",
  :phone          => "(555) 555-5555",
  :contact_name   => "Jose Guzman",
  :contact_email  => "jose.guzman@victoria.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now )

Account.create!( 
  :name           => "Kohl's Department Stores",
  :address        => "N56W17000 Ridgewood Drive",
  :city           => "Menomonee Falls",
  :state          => "WI",
  :zip            => "53201-0359",
  :phone          => "(262) 703-7000",
  :contact_name   => "Sherry Johnson",
  :contact_email  => "sherry.johnsom@kohlscorp.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now )

Account.create!( 
  :name           => "Radio Shack Stores",
  :address        => "300 RadioShack Circle",
  :city           => "Fort Worth",
  :state          => "TX",
  :zip            => "76102-1964",
  :phone          => "(817) 415-3011",
  :contact_name   => "Alex Abernathy Johnson",
  :contact_email  => "alex.abernathy@radioshack.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now )
  
Account.create!(
  :name           => "Sears Stores LLC",
  :address        => "3333 Beverly Road",
  :city           => "Hoffman Estates",
  :state          => "IL",
  :zip            => "60179",
  :phone          => "(817) 415-3011",
  :contact_name   => "George Sears",
  :contact_email  => "george.sears@sears.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now )

# Darlene's Boutique & Billy's Heli Shop parent
Account.create!(
  :name           => "BKDK LLC",
  :address        => "9666 Whitehurst Dr",
  :city           => "Dallas",
  :state          => "TX",
  :zip            => "75243",
  :phone          => "(817) 415-3011",
  :contact_name   => "Bill Kiskin",
  :contact_email  => "bill.k@sbcglobal.net",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now )

Account.create!(
  :name           => "Half Price Books Stores LLC",
  :address        => "5803 East Northwest Highway",
  :city           => "Dallas",
  :state          => "TX",
  :zip            => "75232",
  :phone          => "555-555-1212",
  :contact_name   => "Gordon Alexander",
  :contact_email  => "gordy.al@hpbooks.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now )
  
# Kristian's Scuba King parent
Account.create!(
  :name           => "HoJoLeLa LLC",
  :address        => "411 Buckingham Rd",
  :city           => "Richardson",
  :state          => "TX",
  :zip            => "75081",
  :phone          => "555-555-1212",
  :contact_name   => "Kristian Takvham",
  :contact_email  => "kt@scubaking.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now )

Account.create!(
  :name           => "Walgreen's Stores LLC",
  :address        => "200 Wilmot Road",
  :city           => "Deerfield",
  :state          => "IL",
  :zip            => "60015",
  :phone          => "206-266-1000",
  :contact_name   => "Samuel Walton",
  :contact_email  => "samuel.walton@walgreens.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now )

Account.create!(
  :name           => "Home Depot Stores",
  :address        => "2455 Paces Ferry Rd SE",
  :city           => "Atlanta",
  :state          => "GA",
  :zip            => "30339",
  :phone          => "(800)-466-3337",
  :contact_name   => "Homer Mills Depot",
  :contact_email  => "homer.depot@homedepot.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now )

Account.create!(
  :name           => "Herb's Paint and Body Shops LLC",
  :address        => "12101 Self Plaza Drive",
  :city           => "Dallas",
  :state          => "TX",
  :zip            => "75218",
  :phone          => "(214) 328-4381",
  :contact_name   => "Herbie Hancock",
  :contact_email  => "herbie.hancock@herbs.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now )

Account.create!(
  :name           => "Fry's Electronics Stores LLC",
  :address        => "600 E Brokaw Rd",
  :city           => "San Jose",
  :state          => "CA",
  :zip            => "95112",
  :phone          => "(408) 487-4500",
  :contact_name   => "Chester Fry",
  :contact_email  => "chester.fried@outpost.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now )

Account.create!(
  :name           => "Mobile Users Account",
  :address        => "...na...",
  :city           => "...na...",
  :state          => "na",
  :zip            => "12345",
  :phone          => "555-555-1212",
  :contact_name   => "...na...",
  :contact_email  => "...na...",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now )
Original US Retailers
retailer = RetailerSeed.create!(
  :account_id     => Account.where(:name => "Kohl's Department Stores").first.id,
  :name           => "Kohl's",
  :address        => "5750 Skillman St.",
  :city           => "Dallas",
  :state          => "TX",
  :zip            => "75214",
  :phone          => "555-555-1212",
  :contact_name   => "Bob Evans",
  :contact_email  => "bob.e@kohls.com",
  :url            => "www.kohls.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now,
  :retailer_category_id => RetailerCategory.where(:retailer_category => "All offers - Todas las Ofertas").first.id
)
zone = Map.which_zone?( [ retailer.latitude, retailer.longitude ] )
retailer.update_attribute( :zone, zone ||= 0 )
# Radio Shack
retailer = RetailerSeed.create!(
  :account_id     => Account.where(:name => "Radio Shack Stores").first.id,
  :name           => "Radio Shack",
  :address        => "5618 E Mockingbird Ln",
  :city           => "Dallas",
  :state          => "TX",
  :zip            => "75206",
  :phone          => "555-555-1212",
  :contact_name   => "George McCartney",
  :contact_email  => "georgemc@radioshack.com",
  :url            => "www.radioshack.com",
  :created_at => DateTime.now,
  :updated_at => DateTime.now,
  :retailer_category_id => RetailerCategory.where(:retailer_category => "Entertainment - Entretenimiento").first.id
)
zone = Map.which_zone?( [ retailer.latitude, retailer.longitude ] )
retailer.update_attribute( :zone, zone ||= 0 )
# Sears
retailer = RetailerSeed.create!(
  :account_id     => Account.where(:name => "Sears Stores LLC").first.id,
  :name           => "Sears",
  :address        => "13331 Preston Rd",
  :city           => "Dallas",
  :state          => "TX",
  :zip            => "75240-5223",
  :phone          => "555-555-1212",
  :contact_name   => "Edgar Winter",
  :contact_email  => "edgwinter@sears.com",
  :url            => "www.sears.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now,
  :retailer_category_id => RetailerCategory.where(:retailer_category => "All offers - Todas las Ofertas").first.id
)
zone = Map.which_zone?( [ retailer.latitude, retailer.longitude ] )
retailer.update_attribute( :zone, zone ||= 0 )
# NOTE: these next 2 retailers are associated with the same Account
# Billy's Heli Shop (BKDK)
retailer = RetailerSeed.create!(
  :account_id     => Account.where(:name => "BKDK LLC").first.id,
  :name           => "Billy's Heli Shop",
  :address        => "9666 Whitehurst Dr",
  :city           => "Dallas",
  :state          => "TX",
  :zip            => "75243",
  :phone          => "555-555-1212",
  :contact_name   => "Billy Kiskin",
  :contact_email  => "bill@myemailprovider.com",
  :url            => "www.billyshelishop.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now,
  :retailer_category_id => RetailerCategory.where(:retailer_category => "Entertainment - Entretenimiento").first.id
)
zone = Map.which_zone?( [ retailer.latitude, retailer.longitude ] )
retailer.update_attribute( :zone, zone ||= 0 )
# Darlene's Boutique (BKDK)
retailer = RetailerSeed.create!(
  :account_id     => Account.where(:name => "BKDK LLC").first.id,
  :name           => "Darlene's Boutique",
  :address        => "5000 Greenville Av",
  :city           => "Dallas",
  :state          => "TX",
  :zip            => "75206",
  :phone          => "555-555-1212",
  :contact_name   => "Billy Kiskin",
  :contact_email  => "luc@renoemail.com",
  :url            => "www.darlenesboutique.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now,
  :retailer_category_id => RetailerCategory.where(:retailer_category => "Services - Servicios").first.id
)
zone = Map.which_zone?( [ retailer.latitude, retailer.longitude ] )
retailer.update_attribute( :zone, zone ||= 0 )
# Half Price Books
retailer = RetailerSeed.create!(
  :account_id     => Account.where(:name => "Half Price Books Stores LLC").first.id,
  :name           => "Half Price Books",
  :address        => "5803 East Northwest Highway",
  :city           => "Dallas",
  :state          => "TX",
  :zip            => "75232",
  :phone          => "555-555-1212",
  :contact_name   => "Ariel Lucky",
  :contact_email  => "ariel@hpbooks.com",
  :url            => "www.hpbooks.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now,
  :retailer_category_id => RetailerCategory.where(:retailer_category => "Entertainment - Entretenimiento").first.id
)
zone = Map.which_zone?( [ retailer.latitude, retailer.longitude ] )
retailer.update_attribute( :zone, zone ||= 0 )
# Kristian's Scuba King
retailer = RetailerSeed.create!(
  :account_id     => Account.where(:name => "HoJoLeLa LLC").first.id,
  :name           => "Kristian's Scuba King",
  :address        => "411 Buckingham Rd",
  :city           => "Richardson",
  :state          => "TX",
  :zip            => "75081",
  :phone          => "555-555-1212",
  :contact_name   => "Kristian Takvham",
  :contact_email  => "kt@scubaking.com",
  :url            => "www.scubaking.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now,
  :retailer_category_id => RetailerCategory.where(:retailer_category => "Services - Servicios").first.id
)
zone = Map.which_zone?( [ retailer.latitude, retailer.longitude ] )
retailer.update_attribute( :zone, zone ||= 0 )
# Walgreen's Stores LLC
retailer = RetailerSeed.create!(
  :account_id     => Account.where(:name => "Walgreen's Stores LLC").first.id,
  :name           => "Walgreen's Pharmacy",
  :address        => "6505 Abrams Road",
  :city           => "Dallas",
  :state          => "TX",
  :zip            => "75243",
  :phone          => "555-555-1212",
  :contact_name   => "Darrel Divins",
  :contact_email  => "ddivins@walgreens.com",
  :url            => "www.walgreens.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now,
  :retailer_category_id => RetailerCategory.where(:retailer_category => "Health and Beauty- Salud y Belleza").first.id
)
zone = Map.which_zone?( [ retailer.latitude, retailer.longitude ] )
retailer.update_attribute( :zone, zone ||= 0 )
# Home Depot
retailer = RetailerSeed.create!(
  :account_id     => Account.where(:name => "Home Depot Stores").first.id,
  :name           => "Home Depot",
  :address        => "11682 Forest Central Dr",
  :city           => "Dallas",
  :state          => "TX",
  :zip            => "75243",
  :phone          => "(214) 343-1032",
  :contact_name   => "Scott Johnson",
  :contact_email  => "scott.johnson@homedepot.com",
  :url            => "www.homedepot.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now,
  :retailer_category_id => RetailerCategory.where(:retailer_category => "Services - Servicios").first.id
)
zone = Map.which_zone?( [ retailer.latitude, retailer.longitude ] )
retailer.update_attribute( :zone, zone ||= 0 )
# Herb's Paint and Body
retailer = RetailerSeed.create!(
  :account_id     => Account.where(:name => "Herb's Paint and Body Shops LLC").first.id,
  :name           => "Herb's Paint and Body #6",
  :address        => "3552 West Mockingbird Ln",
  :city           => "Dallas",
  :state          => "TX",
  :zip            => "75235",
  :phone          => "(214) 366-2155",
  :contact_name   => "Herbie Hancock",
  :contact_email  => "herbie.hancock@herbspaintandbody.com",
  :url            => "www.herbspaintandbody.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now,
  :retailer_category_id => RetailerCategory.where(:retailer_category => "Services - Servicios").first.id
)
zone = Map.which_zone?( [ retailer.latitude, retailer.longitude ] )
retailer.update_attribute( :zone, zone ||= 0 )
# Fry's Electronics #1
retailer = RetailerSeed.create!(
  :account_id     => Account.where(:name => "Fry's Electronics Stores LLC").first.id,
  :name           => "Fry's Electronics",
  :address        => "12710 Executive Dr",
  :city           => "Dallas",
  :state          => "TX",
  :zip            => "75238",
  :phone          => "(214) 342-5900",
  :contact_name   => "Gerald Hansen",
  :contact_email  => "gerald.hansenk@outpost.com",
  :url            => "www.outpost.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now,
  :retailer_category_id => RetailerCategory.where(:retailer_category => "Entertainment - Entretenimiento").first.id
)
zone = Map.which_zone?( [ retailer.latitude, retailer.longitude ] )
retailer.update_attribute( :zone, zone ||= 0 )
# Fry's Electronics #2
retailer = RetailerSeed.create!(
  :account_id     => Account.where(:name => "Fry's Electronics Stores LLC").first.id,
  :name           => "Fry's Electronics",
  :address        => "700 E Plano Parkway",
  :city           => "Plano",
  :state          => "TX",
  :zip            => "75074",
  :phone          => "(214) 291-6000",
  :contact_name   => "Taylor Smith",
  :contact_email  => "taylor.smith@outpost.com",
  :url            => "www.outpost.com",
  :created_at     => DateTime.now,
  :updated_at     => DateTime.now,
  :retailer_category_id => RetailerCategory.where(:retailer_category => "Entertainment - Entretenimiento").first.id
)

=end