class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here. For example:

    user ||= User.new

    # Define User abilities
    if user.role == 'admin'
      can :manage, :all
    else
      can :manage, Post, author: user
      can :manage, Comment, author: user
      can :read, :all
    end
  end
end
