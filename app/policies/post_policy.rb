class PostPolicy < ApplicationPolicy
  attr_reader :user, :record
  
  def initialize(user,post)
    @post = post
    @user=user
  end 
  
  def owned
    @post.user_id == @user.id
  end
  
  def create?
    owned
  end
  
  def update?
    owned
  end

  def destroy?
    owned
  end

end
