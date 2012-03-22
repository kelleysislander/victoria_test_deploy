class Ability
  
  include CanCan::Ability

  def initialize(user)
    
    user ||= User.new  #Guest user

    if user.role? :superadmin
      can :manage, :all
    end
    
    if user.role? :admin
      can :manage, :all
      cannot [:create, :destroy, :edit], User
    end

    if user.has_role? ([:deal, :advertisement, :redemption, :retailer])
      # user can update, read their own User records 
      can [:index, :update, :edit, :show], User do |u|
        u == user
      end
      # user can index and show their own accounts (where user.account_id = account.id)
      can [:index,:show], Account do |a|
        a == user.account
      end
      cannot [:destroy], User
    end
    
    if user.has_role? ([:retailer])
      # can manage Retailers where there is a retailer record and retailer.account_id = user.account_id 
      can :manage, Retailer do |retailer|
        retailer && (retailer.try(:account) == user.account)
      end
    end

    if user.has_role? ([:advertiser])
      # can manage Advertisers
      can :manage, Advertiser
    end

    if user.has_role? ([:deal])
      # can manage Deals where there is a deal record and deal.account_id = user.account_id
      can :manage, Deal
    end

    if user.has_role? ([:redemption])
      can :manage, Redemption
      # can :index,:edit,:update,:show Deals and Retailers where there is a deal record and deal.account_id = user.account_id
      cannot [:destroy, :create], Deal
      can [:index,:edit,:update,:show], Deal do |deal|
        deal && deal.retailer && (deal.retailer.try(:account) == user.account)
      end
      cannot [:destroy, :create], Retailer
      can [:index,:edit,:update,:show], Retailer do |retailer|
        retailer && (retailer.try(:account) == user.account)
      end
    end

    if user.role? (:advertisement)
      # can manage Advertisement where there is an advertisement record and advertisement.retailer.account_id = user.account_id
      can :manage, Advertisement do |advertisement|
        advertisement && advertisement.retailer && (advertisement.retailer.try(:account) == user.account)
      end
    end

    if user.has_role? ([:traffic])
      # can manage Traffic Cams and Traffic Conditions (alerts)
      can :manage, TrafficCamera
      can :manage, TrafficCondition
      can :manage, TrafficConditionHistorical
    end
    
  end
end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
