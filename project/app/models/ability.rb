class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
       user ||= current_user # guest user (not logged in)
       
       #iterate over each role, a user can has many.
       user.roles.each do |role|
         
         if(role.name == 'Administrator')
            can :manage, Area
            can :manage, City
            can :manage, Customer
            can :manage, Employee
            can :manage, ForeingCompany
            can :manage, FunctionType
            can :manage, PaymentMethod
            can :manage, ProductState
            can :manage, ProductType
            can :manage, Product
            can :manage, Reason
            can :manage, Receiver
            can :manage, RetireNote
            can :manage, Role
            can :manage, RoutingSheetState
            can :manage, RoutingSheet
            can :manage, ServiceType
            can :manage, TransportGuideDetail
            can :manage, TransportGuideState
            can :manage, TransportGuide
            can :manage, User
            can :manage, RolesUsers
         elsif role.name == 'Transporter'
            can :manage, RetireNote
            can :manage, RoutingSheet
            can :manage, TransportGuide
            can :manage, TransportGuideDetail
         elsif role.name == 'Secretary' 
           #permissions for secretary role
         end
         
         
         
       end
       
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
  end
end
