# frozen_string_literal: true

class ListingPolicy
  attr_reader :user, :listing

  def initialize(user, listing)
    @user = user
    @listing = listing
  
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def new?
    create?
  end
  # Give update permission if the user is an admin or is the creator of a given listing
  def update?
    user.has_role? :creator, @listing or user.has_role? :admin
  end

  def edit?
    update?
  end
  # Give destroy permission on same condition as update
  def destroy?
    update?
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end

    private

    attr_reader :user, :scope
  end
end
