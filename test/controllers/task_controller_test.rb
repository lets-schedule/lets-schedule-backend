require "test_helper"

# does a task have to have at least one event?
# check that task belongs to a user?

class TaskControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "task should have user and conflict" do
    task = Task.new()
    assert_not task.save, "Saved task "
  end

  test

end
