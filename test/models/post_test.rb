require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user=FactoryGirl.create(:user)
    @post = FactoryGirl.create(:post, user:@user)
    @post2 = FactoryGirl.create(:post, user:@user)
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "user id should be present" do
    @post.user_id = nil
    assert_not @post.valid?
  end
  
  test "content should be present" do
    @post.content = "   "
    assert_not @post.valid?
  end

  test "content should be at most 10000 characters" do
    @post.content = "a" * 10001
    assert_not @post.valid?
  end

  test "order should be most recent first" do
    assert_equal @post2, Post.first
  end
end
