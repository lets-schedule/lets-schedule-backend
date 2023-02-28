require "test_helper"

class ConstraintControllerTest < ActionDispatch::IntegrationTest

  # create constraint with duetime and duration
  test "create constraint with duetime and duration" do

    tokenAuth = sign_in_api_user(users(:user_task_noconstraint).email)

    route = "/task/" + tasks(:task_noconstraint).id.to_s + "/constraint"

    newTime = "2023-02-21 00:00:00 UTC" 
    newDuration = 10

    post route,
      headers: { 'Authorization': tokenAuth },
      params: { constraint: { dueTime: newTime, duration: newDuration } }  

    assert_response :success

    @createdConstraint = Task.find(tasks(:task_noconstraint).id).constraint

    assert_equal newTime, @createdConstraint.dueTime.to_s
    assert_equal newDuration, @createdConstraint.duration

  end

  # create constraint with duetime and no duration
  test "create constraint with duetime and no duration" do
    tokenAuth = sign_in_api_user(users(:user_task_noconstraint).email)
    route = "/task/" + tasks(:task_noconstraint).id.to_s + "/constraint"

    newDueTime = "2023-02-21 00:00:00 UTC"

    post route,
      headers: { 'Authorization': tokenAuth },
      params: { constraint: { dueTime: newDueTime } }

    assert_response :success

    @createdConstraint = Task.find(tasks(:task_noconstraint).id).constraint

    assert_equal newDueTime, @createdConstraint.dueTime.to_s
    assert_nil @createdConstraint.duration

  end

  # create constraint with duration and no duetime
  test "create constraint with duration and no duetime" do
    tokenAuth = sign_in_api_user(users(:user_task_noconstraint).email)
    route = "/task/" + tasks(:task_noconstraint).id.to_s + "/constraint"

    newDuration = 10

    post route,
      headers: { 'Authorization': tokenAuth },
      params: { constraint: { duration: newDuration } }

    assert_response :success

    @createdConstraint = Task.find(tasks(:task_noconstraint).id).constraint

    assert_equal newDuration, @createdConstraint.duration
    assert_nil @createdConstraint.dueTime

  end

  # create constraint with no args (error)
  test "create constraint with no args (error)" do
    tokenAuth = sign_in_api_user(users(:user_task_noconstraint).email)
    route = "/task/" + tasks(:task_noconstraint).id.to_s + "/constraint"

    assert_raises() do

      post route,
        headers: { 'Authorization': tokenAuth },
        params: { constraint: { } }

    end

  end

  # create constraint for task that does not exist (error)
  test "create constraint for task that does not exist (error)" do
    tokenAuth = sign_in_api_user(users(:user_task_noconstraint).email)
    route = "/task/9999/constraint"

    assert_raises() do
      post route,
        headers: { 'Authorization': tokenAuth },
        params: { constraint: { dueTime: Time.now, duration: 10} }
    end

  end

  # update a constraint dueTime
  test "update a constraint dueTime" do
    tokenAuth = sign_in_api_user(users(:user_task_constraint).email)
    route = "/task/" + tasks(:task_with_constraint).id.to_s + "/constraint"

    origDueTime = Task.find(tasks(:task_with_constraint).id).constraint.dueTime

    newDueTime = "1992-02-21 00:00:00 UTC"

    patch route,
      headers: { 'Authorization': tokenAuth },
      params: { constraint: { dueTime: newDueTime } }

    assert_response :success

    @updatedConstraint = Task.find(tasks(:task_with_constraint).id).constraint

    assert_equal newDueTime, @updatedConstraint.dueTime.to_s 

  end

  # update constraint duration
  test "update constraint duration" do
    tokenAuth = sign_in_api_user(users(:user_task_constraint).email)
    route = "/task/" + tasks(:task_with_constraint).id.to_s + "/constraint"

    newDuration = 20

    patch route,
      headers: { 'Authorization': tokenAuth },
      params: { constraint: { duration: newDuration } }

    assert_response :success

    @updatedConstraint = Task.find(tasks(:task_with_constraint).id).constraint

    assert_equal newDuration, @updatedConstraint.duration

  end

  # update both duetime and duration of existing constraint
  test "update both duetime and duration of existing constraint" do
    tokenAuth = sign_in_api_user(users(:user_task_constraint).email)
    route = "/task/" + tasks(:task_with_constraint).id.to_s + "/constraint"

    newDuration = 20;
    newDueTime = "1992-02-21 00:00:00 UTC"

    patch route,
      headers: { 'Authorization': tokenAuth },
      params: { constraint: { dueTime: newDueTime, duration: newDuration} }

    assert_response :success
    @updatedConstraint = Task.find(tasks(:task_with_constraint).id).constraint

    assert_equal newDuration, @updatedConstraint.duration
    assert_equal newDueTime, @updatedConstraint.dueTime.to_s

  end

  # update with no args (error)
  test "update with no args (error)" do
    tokenAuth = sign_in_api_user(users(:user_task_constraint).email)

    route = "/task/" + tasks(:task_with_constraint).id.to_s + "/constraint"

    assert_raises() do
      patch route,
        headers: { 'Authorization': tokenAuth },
        params: { constraint: {  } }
    end

  end

  # update with non-existant task (error)
  test "update with non-existant task (error)" do

    tokenAuth = sign_in_api_user(users(:user_task_constraint).email)
    route = "/task/9999/constraint"

    assert_raises() do
      patch route,
        headers: { 'Authorization': tokenAuth },
        params: { constraint: { duration: 10, dueTime: Time.now  } }
    end

  end

  # update non existant constraint
  test "update non existant constraint" do
    tokenAuth = sign_in_api_user(users(:user_task_constraint).email)

    route = "/task/" + tasks(:task_noconstraint).id.to_s + "/constraint"

    newTime = "2023-02-21 00:00:00 UTC" 
    newDuration = 10

    assert_raises() do
      patch route,
        headers: { 'Authorization': tokenAuth },
        params: { constraint: { dueTime: newTime, duration: newDuration } }  
    end
  end

end

