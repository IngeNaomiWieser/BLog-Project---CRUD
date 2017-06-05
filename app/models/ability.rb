class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # just making sure there is a user

    # Alleen de maker van de post dan de post pdaten en verwijderen
    can [:edit, :update, :destroy], Post do |post|
      user == post.user
    end

    # Alleen de maker van de comment kan de comment verwijderen
    can :destroy, Comment do |comment|
      comment.user == user
    end

    #Degene die het product gecreerd heeft, kan geen review creeren.
    # can :create, Review do |review|
    #   user != review.product.user
    # end

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
