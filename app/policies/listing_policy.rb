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
  
  def update?
    user.has_role? :creator, @listing 
  end

  def edit?
    update?
  end

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
