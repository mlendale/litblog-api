class UserPolicy < ApplicationPolicy
  attr_reader :user, :record
  def create?
    return true
  end

  def update?
    return true if @record.id == @user.id
  end

  def destroy?
    return true if @record.id == @user.id
  end

end
