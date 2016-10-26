class PostPolicy < ApplicationPolicy
  attr_reader :user, :record

  def update?
    return true if @record.user == user
  end

  def destroy?
    return true if @record.user == user
  end

end
