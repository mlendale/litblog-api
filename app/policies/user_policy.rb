class UserPolicy < ApplicationPolicy
  attr_reader :user, :post

  def update?
    return true if @record.id == @user.id
  end

  def destroy?
    return true if @record.id == @user.id
  end

end
