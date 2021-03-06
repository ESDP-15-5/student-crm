class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)

    if user.has_role? :admin
      #Может управлять всем
      can :manage, :all
      can :assign_roles, User
    elsif user.has_role? :manager
      #Может управлять всем, пока что
      can :manage, Course
      can :manage, CourseElement
      can :manage, CourseElementMaterial
      can :manage, CourseElementFile
      can :manage, Period
      can :manage, Group
      can :manage, GroupMembership
      can :manage, User

    elsif user.has_role? :teacher
      #Может просматривать профили всех пользователей
      can :read, User
      #Может управлять своим профилем
      can [:show, :update], User, :id => user.id
    elsif user.has_role? :assistent
      #Может просматривать профили всех пользователей
      can :read, User
      #Может управлять своим профилем
      can [:show, :update], User, :id => user.id

    elsif user.has_role? :student
      #Может управлять своим профилем
      can :read, User
      can :read, CourseElement
      can :read, CourseElementMaterial
      can [:show, :update ], User, :id => user.id

    else

    end


    # Left the comments to surve as a mini documentation
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
