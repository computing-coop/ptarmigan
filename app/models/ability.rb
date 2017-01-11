class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :riga_staff
      can :manage, Event
      can :manage, Calendarbackground
      can :manage, Instance
      can :manage, Place
      can :manage, Ctad
      can :manage, Radiolink
      can :manage, Article
    elsif user.has_role? :madhouse_staff
      can :manage, Event , location: {name: 'Mad House' }
      # can :create, Event, location: {name: 'Mad House' }
      can :manage, Post, location: {name: 'Mad House' }
      can :manage, Page, location: {name: 'Mad House' }
      can :manage, Flicker, event: {location: {:name => 'Mad House' } }
      # can :create, Flicker,  event: {location: {:name => 'Mad House' } }
      can :manage, Place
      cannot :manage, Ctad
      cannot :manage, Article
      cannot :manage, Radiolink
      can :manage, Resource, location: {name: 'Mad House' }
    else
      cannot :manage, :all
      cannot :manage, Event
      cannot :manage, Ctad
      can :manage, Place
      cannot :manage, Article
      cannot :manage, Radiolink

    end
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
