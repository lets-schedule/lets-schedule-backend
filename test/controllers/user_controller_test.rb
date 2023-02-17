require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest
  #   test "the truth" do
  # assert true
  # end
  test "user should have name and email" do
    @user = User.new
    assert_not @user.save, "Saved user without name and email"
  end

  test "user create" do
    @user = User.create(:name => "name", :email => "email@email.com")
    assert @user.save
  end
  
  test "user destroy" do
    @user = User.create(:name => "firstname", :email => "firstname@email.com")
    uid = @user.id
    assert_equal(User.find(uid), @user)
    User.destroy(uid)
    assert_raise(Exception) {User.find(uid)}
  end
  
end
