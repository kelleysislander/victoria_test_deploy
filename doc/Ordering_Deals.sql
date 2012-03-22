SELECT r.name, d.*
FROM deals d 
join retailers r on r.id = d.retailer_id

Strategy for selecting the 3 types of Deals (Featured, Zone, and Regular)

Deals List:

1.  Get 3 resultsets randomly ordered for each deal category of "Featured", "Zone", and "Regular" within the give user's lat / lng and predetermined radius from that lat / lng point
2.  "n_deals" => all active deals available; the total of "Featured", "Zone", and "Regular" from step 1, above
3.  "n_ads" => all active advertisements available
4.  "ad_ratio" = "0.2" 20% => fixed ratio of advertisements to deals to intersperse within the "n_deals" deals
5.  "ad_modulo" = n_deals * ad_ratio, so if n_deals = 100 deals then ad_modulo = 100 / 20 = 5; after every 5th deal is an advertisement

3 categories:

Featured
Zone (deals within)

Theoretical:

The hierarchy for presenting deals is Featured, Zone (deals within the mobile user's current "zone"), and Regular (all the rest).

The purpose of this strategy is to fairly allocate the quantity and type of deals (Featured, Zone, and Regular) selected so that no one category
is over-represented and no one category is under-represented.  Over / Under for the category above will be flowed into the next lower category.

We will start with the total number of active deals available ("n") and assign an upper limit for each type.  For the sake of starting at some level 
we will divide the total number of active deals available by 3 for an equal allocation of the 3 categories.  We will call this number 
"n3_featured", "n3_zone" and "n3_regular", short for "n / 3" where "n" is the total deals available. We will also assign values for the total number of 
deals available for each category: "n_featured", "n_zone", and "n_regular"

In the event that there are not enough deals of the "Featured" category (n_featured < n3_featured) then the difference between n3_featured and the actual 
number of Featured deals available (we will compute it as: n3_featured_shortfall = n_featured - n3_featured) is allocated for the next lower level of "Zone" 
deals by computing ("n_zone_available" = n_zone + n3_featured_shortfall), subject to the limit that "n3_zone" cannot be larger than "n_zone".

We compute "n_zone_n3_zone_delta" as 
If n_zone_available > n3_zone then we store that value as n_zone_n3 

If after that the "Zone" category does not have enough deals then the difference between n3_zone and the actual number 
the difference between n3 and the actual number available is allocated to the "Regular" category