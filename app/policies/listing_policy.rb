# frozen_string_literal: true

class ListingPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
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

  # user.has_any_role?(:admin, :creator)
  
  def update?
    user.has_any_role?(:admin)
  end

  def edit?
    update?
  end

  def destroy?
    user.has_any_role?(:admin)
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
