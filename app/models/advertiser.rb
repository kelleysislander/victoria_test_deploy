class Advertiser < ActiveRecord::Base
  
  paginates_per 10 # kaminari pagination

  has_many    :deals
  has_many    :advertisements
  has_many    :retailers, :through => :advertisements
  
  belongs_to  :advertiser_type
  belongs_to  :retailer  
  # NOTE: optionally belongs_to: if the Advertiser has a retailer_id and the advertiser_id == retailer_id then the advertiser is also the retailer (sole proprietorship, Mom & Pop shop, etc)
  # if the Advertiser has no retailer_id then the advertiser is not the retailer; it is a separate but related entity
  
  validates_presence_of :advertiser_type_id
  validates_presence_of [:address, :city, :state], :if => Proc.new {|a| a.retailer_id.blank?}
  
  validates_uniqueness_of :name, :scope => :address, :if => Proc.new {|a| a.retailer_id.blank?}
  
  validates_length_of :name,    :within => 5..255,  :too_long => "Maximum size for 'Name' is 255.",     :too_short => "Minimum size for 'Name' is 5.",    :if => Proc.new {|a| a.retailer_id.blank?}
  validates_length_of :address, :within => 5..255,  :too_long => "Maximum size for 'Address' is 255.",  :too_short => "Minimum size for 'Address' is 5.", :if => Proc.new {|a| a.retailer_id.blank?}
  validates_length_of :city,    :within => 5..255,  :too_long => "Maximum size for 'City' is 255.",     :too_short => "Minimum size for 'City' is 5.",    :if => Proc.new {|a| a.retailer_id.blank?}
  validates_length_of :state,   :within => 2..255,  :too_long => "Maximum size for 'Country' is 255.",  :too_short => "Minimum size for 'Country' is 2.", :if => Proc.new {|a| a.retailer_id.blank?}
  # validates_length_of :zip,     :within => 5..10,   :too_long => "Maximum size for 'Zip' is 10.",       :too_short => "Minimum size for 'Zip' is 5.",     :if => Proc.new {|a| a.retailer_id.blank?}
  
  # validates_uniqueness_of(:retailer_id, :message => "That Retailer ID is already set up as an Advertiser", :if => Proc.new { |r| !r.retailer_id.nil? } )
    
end

=begin


This is a representation of the data in the "Advertisers" table.  Note the firtst 2 recs... This is the  case where the advertiser = retailer, where
the recs have a "retailer_id" that points to the "Retailers" table, hence the empty attributes of address, city, state, etc. since they are stored in
the "Retailers" table  
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
ADVERTISERS:

id	advertiser_type_id	retailer_id	name	                  address	                          city	          state	zip	        phone	            contact_name	contact_email	created_at	          updated_at
1	          2	              7	    NULL	                    NULL	                            NULL	          NULL	NULL	      NULL	              NULL	            NULL	  "2011-11-15 16:04:57"	"2011-11-15 16:04:57"
2	          2	              5	    NULL	                    NULL	                            NULL	          NULL	NULL	      NULL	              NULL	            NULL	  "2011-11-15 16:04:57"	"2011-11-15 16:04:57"
3	          2	              NULL	"Proctor & Gamble"	      "5299 Spring Grove Ave"	          Cincinnati	      OH	45202	      "(513) 983-1100"	  NULL	            NULL	  "2011-11-15 16:04:57"	"2011-11-15 16:04:57"
4	          1	              NULL	"Amazon.com, Inc."	      "1200 12th Ave. South, Ste. 1200"	Seattle	          WA	98144-2734	206-266-1000	      NULL	            NULL	  "2011-11-15 16:04:57"	"2011-11-15 16:04:57"
5	          2	              NULL	"Walgreens's Corporate"	  "200 Wilmot Road"	                Deerfield	        IL	60015	      206-266-1000	      NULL	            NULL	  "2011-11-15 16:04:57"	"2011-11-15 16:04:57"
6	          2	              NULL	"Kohl's Corporate"	      "N56W17000 Ridgewood Drive"	      "Menomonee Falls"	WI	53201-0359	"(262) 703-7000"	  NULL	            NULL	  "2011-11-15 16:04:57"	"2011-11-15 16:04:57"
7	          2	              NULL	"Radio Shack Corporate"	  "300 Radio Shack Circle"	        "Fort Worth"	    TX	76102-1964	"(817) 415-3700"	  NULL	            NULL	  "2011-11-15 16:04:57"	"2011-11-15 16:04:57"
8	          2	              NULL	"Sears Corporate"	        "3333 Beverly Road"	              "Hoffman Estates"	IL	60179	      "(847) 286-2500 "	  NULL	            NULL	  "2011-11-15 16:04:57"	"2011-11-15 16:04:57"

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
RETAILERS:

id	name	                  address	                      city	    state	zip	        phone	        contact_name	      contact_email	            created_at	          updated_at	          latitude	longitude	retailer_category_id
1	  Kohl's	                "5750 Skillman St."	          Dallas	    TX	75214	      555-555-1212	"Bob Evans"	        bob.e@kohls.com	          "2011-11-15 16:04:55"	"2011-11-15 16:04:55"	32.8575	  -96.7558	      10
2	  "Radio Shack"	          "5618 E Mockingbird Ln"	      Dallas	    TX	75206	      555-555-1212	"George McCartney"	georgemc@radioshack.com	  "2011-11-15 16:04:56"	"2011-11-15 16:04:56"	32.8365	  -96.7714	      3
3	  Sears	                  "13331 Preston Rd"	          Dallas	    TX	75240-5223	555-555-1212	"Edgar Winter"	    edgwinter@sears.com	      "2011-11-15 16:04:56"	"2011-11-15 16:04:56"	32.9293	  -96.8081	      10
4	  "Billy's Heli Shop"	    "9666 Whitehurst Dr"	        Dallas	    TX	75243	      555-555-1212	"Billy Kiskin"	    bill@semaphoremobile.com	"2011-11-15 16:04:57"	"2011-11-15 16:04:57"	32.9011	  -96.7295	      9
5	  "Darlene's Boutique"	  "5000 Greenville Av"	        Dallas	    TX	75206	      555-555-1212	"Billy Kiskin"	    luc@renoemail.com	        "2011-11-15 16:04:57"	"2011-11-15 16:04:57"	32.848	  -96.7698	      11
6	  "Half Price Books"	    "5803 East Northwest Highway"	Dallas	    TX	75232	      555-555-1212	"Ariel Lucky"	      ariel@hpbooks.com	        "2011-11-15 16:04:57"	"2011-11-15 16:04:57"	32.8659	  -96.7647	      9
7	  "Kristian's Scuba King"	"411 Buckingham Rd"	          Richardson	TX	75081	      555-555-1212	"Kristian Takvham"	kt@scubaking.com	        "2011-11-15 16:04:57"	"2011-11-15 16:04:57"	32.9348	  -96.7288	      9
8	  "Walgreen's Pharmacy"	  "6505 Abrams Road"	          Dallas	    TX	75243	      555-555-1212	"Darrel Divins"	    ddivins@walgreens.com	    "2011-11-15 16:04:57"	"2011-11-15 16:04:57"	32.8632	  -96.7449	      9

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

relationship between advertisements, retailers, and advertisers:

SELECT
  a.retailer_id as advertiser_retailer_id,
  advment.retailer_id as advertisement_retailer_id,
  advment.advertiser_id as advertisement_advertiser_id,
  advment.name as advertisement_name,
--  a.name as advertiser_name,
  IFNULL(a.name, r.name) as advertiser,
  r.name as retailer_name,
  CASE 
    WHEN a.retailer_id IS NULL
    THEN 'N' 
    ELSE 'Y' 
  END as "advertiser_is_retailer?"
FROM advertisements advment
JOIN retailers r ON r.id = advment.retailer_id
JOIN advertisers a ON a.id = advment.advertiser_id
LEFT JOIN retailers r_as_a ON r_as_a.id = advment.retailer_id;

=end

=begin
http://railsforum.com/viewtopic.php?id=12524

validates_presence_of :phone, :if => Proc.new {|u| !u.phone2.blank?}
validates_length_of :phone2, :is => 8, :if => Proc.new {|u| !u.phone2.blank?}
    validates_presence_of :phone, :phone2, :if => Proc.new {|u| !u.phone3.blank?}
    validates_length_of :phone3, :is => 8, :if => Proc.new {|u| !u.phone3.blank?}
    
class Person < ActiveRecord::Base
  validates_length_of :first_name, :maximum => 30
  validates_length_of :last_name, :maximum => 30, :message => "less than %d if you don't mind"
  validates_length_of :fax, :in => 7..32, :allow_nil => true
  validates_length_of :phone, :in => 7..32, :allow_blank => true
  validates_length_of :user_name, :within => 6..20, :too_long => "pick a shorter name", :too_short => "pick a longer name"
  validates_length_of :fav_bra_size, :minimum => 1, :too_short => "please enter at least %d character"
  validates_length_of :smurf_leader, :is => 4, :message => "papa is spelled with %d characters... don't play me."
end
  
=end