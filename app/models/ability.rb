class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new

    can :manage, Post do |q|
      q.user == user
    end

    can :manage, Comment do |c|
      c.user == user
    end

    if user.is_admin?
      #this means that if a user has the 'is_admin' field set to 'true' that user will be able to manage all the models we have
      can :manage, :all
    else
      can :read, :all?
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
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
