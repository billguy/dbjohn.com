class Ability
  include CanCan::Ability

  def initialize(user)
    def initialize(user)
      if user && user.valid?
        can :manage, :all
        can :access, :rails_admin
        can :dashboard
      end
    end
  end
end
