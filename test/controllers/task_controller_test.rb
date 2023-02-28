require "test_helper"

class TaskControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  # test get task -- returns empty array
  test "get tasks -- none exist" do

    authToken = sign_in_api_user(users(:user_has_name).email)

    get "/task",
      headers: { 'Authorization': authToken }

    assert_response :success
    assert_equal "[]", @response.body
  end

  # Test get all tasks 1 existing task -- sort by title 
  test "get all tasks -- 1 exists -- sort by due time" do

    authToken = sign_in_api_user(users(:user_1task_noEvents).email)

    get "/task?sort=title",
      headers: { "Authorization": authToken }

    json_response = JSON.parse(@response.body)

    assert_response :success

    assert_equal(tasks(:task_noEvents).title.to_s, json_response[0]["title"].to_s)
  end

  # Test get all tasks 1 existing task -- sort by priority
  test "get all tasks -- 1 exists -- sort by priority" do

    authToken = sign_in_api_user(users(:user_1task_noEvents).email)

    get "/task?sort=priority",
      headers: { "Authorization": authToken }

    json_response = JSON.parse(@response.body)

    assert_response :success

    assert_equal(tasks(:task_noEvents).title.to_s, json_response[0]["title"].to_s)
  end

  # Test get all tasks 1 existing task -- sort by category
  test "get all tasks -- 1 exists -- sort by category" do

    authToken = sign_in_api_user(users(:user_1task_noEvents).email)

    get "/task?sort=category",
      headers: { "Authorization": authToken }

    json_response = JSON.parse(@response.body)

    assert_response :success

    assert_equal(tasks(:task_noEvents).title.to_s, json_response[0]["title"].to_s)
  end

  # Test get all tasks 2 existing task -- sort by title
  test "get all tasks -- 2 exists -- sort by title" do

    authToken = sign_in_api_user(users(:user_twotasks_noevents).email)

    get "/task?sort=title",
      headers: { "Authorization": authToken }

    json_response = JSON.parse(@response.body)

    assert_response :success

    assert_equal tasks(:task_one_of_two_noevents).id, json_response[0]["id"]
    assert_equal tasks(:task_two_of_two_noevents).id, json_response[1]["id"]


  end
  # Test get all tasks 2 existing task -- sort by priority
  test "get all tasks -- 2 exists -- sort by priority" do

    authToken = sign_in_api_user(users(:user_twotasks_noevents).email)

    get "/task?sort=priority",
      headers: { "Authorization": authToken }

    json_response = JSON.parse(@response.body)

    assert_response :success

    assert(json_response[0]["priority"] <= json_response[1]["priority"])

    assert_equal tasks(:task_one_of_two_noevents).id, json_response[1]["id"]
    assert_equal tasks(:task_two_of_two_noevents).id, json_response[0]["id"]

  end
  # Test get all tasks 2 existing task -- sort by category
  test "get all tasks -- 2 exists -- sort by category" do

    authToken = sign_in_api_user(users(:user_twotasks_noevents).email)

    get "/task?sort=category",
      headers: { "Authorization": authToken }

    json_response = JSON.parse(@response.body)

    assert_response :success

    assert(json_response[0]["category"] <= json_response[1]["category"])

    assert_equal tasks(:task_one_of_two_noevents).id, json_response[1]["id"]
    assert_equal tasks(:task_two_of_two_noevents).id, json_response[0]["id"]

  end
  # Test get all tasks 3 existing task -- sort by title 
  test "get all tasks -- 3 exists -- sort by title" do

    authToken = sign_in_api_user(users(:user_three_tasks_noevents).email)

    get "/task?sort=title",
      headers: { "Authorization": authToken }

    json_response = JSON.parse(@response.body)

    assert_response :success

    assert(json_response.length == 3)

    assert(json_response[0]["title"] <= json_response[1]["title"])
    assert(json_response[1]["title"] <= json_response[2]["title"])

    assert_equal tasks(:task_one_of_three_noevents).id, json_response[0]["id"]
    assert_equal tasks(:task_two_of_three_noevents).id, json_response[1]["id"]
    assert_equal tasks(:task_three_of_three_noevents).id, json_response[2]["id"]

  end

  # Test get all tasks 3 existing task -- sort by priority
  test "get all tasks -- 3 exist -- sort by priority" do

    authToken = sign_in_api_user(users(:user_three_tasks_noevents).email)

    get "/task?sort=priority",
      headers: { "Authorization": authToken }

    json_response = JSON.parse(@response.body)

    assert_response :success

    assert(json_response.length == 3)

    assert(json_response[0]["priority"] <= json_response[1]["priority"])
    assert(json_response[1]["priority"] <= json_response[2]["priority"])

    assert_equal tasks(:task_one_of_three_noevents).id, json_response[2]["id"]
    assert_equal tasks(:task_two_of_three_noevents).id, json_response[1]["id"]
    assert_equal tasks(:task_three_of_three_noevents).id, json_response[0]["id"]

  end
  # Test get all tasks 3 existing task -- sort by category
  test "get all tasks -- 3 exist -- sort by category" do

    authToken = sign_in_api_user(users(:user_three_tasks_noevents).email)

    get "/task?sort=category",
      headers: { "Authorization": authToken }

    json_response = JSON.parse(@response.body)

    assert_response :success

    assert(json_response.length == 3)

    assert(json_response[0]["category"] <= json_response[1]["category"])
    assert(json_response[1]["category"] <= json_response[2]["category"])

    assert_equal tasks(:task_one_of_three_noevents).id, json_response[0]["id"]
    assert_equal tasks(:task_two_of_three_noevents).id, json_response[2]["id"]
    assert_equal tasks(:task_three_of_three_noevents).id, json_response[1]["id"]

  end

  # Test get a specific task by id -- DNE error
  test "get task by non-existing id error" do

    authToken = sign_in_api_user(users(:user_with_no_tasks).email)

    assert_raises() do
      get "/task/999999",
        headers: { "Authorization": authToken }
      assert_response 404
    end


  end

  # Test get an existing task success 
  test "get existing task success" do

    authToken = sign_in_api_user(users(:user_1task_noEvents).email)

    get "/task/3",
      headers: { 'Authorization': authToken }

    assert_response :success

    json_response = JSON.parse(@response.body)

    assert_equal tasks(:task_noEvents).id, json_response["id"]

  end

  # Create a task with title
  test "create task with title" do

    authToken = sign_in_api_user(users(:user_1task_noEvents).email)
    title_of_new_task = "this is the title of a new task!"

    post "/task",
      headers: { 'Authorization': authToken },
      params: { task: { title: title_of_new_task } } 

    assert_response :success

    assert_not_nil User.find(users(:user_1task_noEvents).id).tasks.where("title = ?", title_of_new_task)

  end

  # Create a task with priority (no title error)
  test "create task with priority error" do

    authToken = sign_in_api_user(users(:user_1task_noEvents).email)

    assert_raises() do
      post "/task",
        headers: { 'Authorization': authToken },
        params: { task: { priority: 1} } 

      assert_response 422
    end

  end
  # Create a task with category (no title error)
  test "create task with category only error" do

    authToken = sign_in_api_user(users(:user_1task_noEvents).email)

    assert_raises() do
      post "/task",
        headers: { 'Authorization': authToken },
        params: { task: { category: 1} } 

      assert_response 422
    end

  end
  # Create a task with title, priority 
  test "create task with title & priority only" do

    authToken = sign_in_api_user(users(:user_1task_noEvents).email)
    new_title = "this is the new task title!"
    new_priority = 3

    post "/task",
      headers: { 'Authorization': authToken },
      params: { task: { title: new_title, priority: new_priority} } 

    assert_response :success

    assert_not_nil User.find(users(:user_1task_noEvents).id).tasks.where("title = ?", new_title)
    assert_not_nil User.find(users(:user_1task_noEvents).id).tasks.where("priority = ?", new_priority)

  end
  # Create a task with title, category
  test "create task with title & category only" do

    authToken = sign_in_api_user(users(:user_1task_noEvents).email)
    new_title = "this is the new task title!"
    new_category = 3

    post "/task",
      headers: { 'Authorization': authToken },
      params: { task: { title: new_title, category: new_category} } 

    assert_response :success

    assert_not_nil User.find(users(:user_1task_noEvents).id).tasks.where("title = ?", new_title)
    assert_not_nil User.find(users(:user_1task_noEvents).id).tasks.where("category = ?", new_category)

  end
  # Create a task with title, priority, category
  test "create task with title, category, & priority " do

    authToken = sign_in_api_user(users(:user_1task_noEvents).email)
    new_title = "this is the new task title!"
    new_category = 3
    new_priority = 2

    post "/task",
      headers: { 'Authorization': authToken },
      params: { task: { title: new_title, category: new_category, priority: new_priority} } 

    assert_response :success

    assert_not_nil User.find(users(:user_1task_noEvents).id).tasks.where("title = ?", new_title)
    assert_not_nil User.find(users(:user_1task_noEvents).id).tasks.where("category = ?", new_category)
    assert_not_nil User.find(users(:user_1task_noEvents).id).tasks.where("priority= ?", new_priority)

  end

  # Create a task with no args (ERROR)
  test "create task with no args error" do

    authToken = sign_in_api_user(users(:user_1task_noEvents).email)

    assert_raises() do
      post "/task",
        headers: { 'Authorization': authToken },
        params: { task: { } }

      assert_response 422
    end
    
  end

  # Create a task... non signed in error
  test "no auth create task error" do

    assert_raises() do
      post "/task",
        params: { task: { title: "this is not gonna work", priority: 1, category: 1 } }

    end
  end

  # Delete an existing task
  test "delete an existing task" do

    authToken = sign_in_api_user(users(:user_1task_noEvents).email)

    delete "/task/3",
        headers: { 'Authorization': authToken }

    assert_response :success

    assert_equal [], User.find(users(:user_1task_noEvents).id).tasks

  end

  # Delete a non-existing task (error)
  test "delete non-existing task error" do

    authToken = sign_in_api_user(users(:user_1task_noEvents).email)

    assert_raises() do
      delete "/task/999",
        headers: { 'Authorization': authToken }
    end
  end

  # Events are deleted when task is deleted
  test "events are deleted when tasks are deleted" do

    authToken = sign_in_api_user(users(:user_1task_2Events).email)

    delete "/task/5",
      headers: { 'Authorization': authToken }

    assert_response :success

    assert_raises() do 
      Task.find(5)
    end

    assert_raises() do
		Event.find(2)
	end
    assert_raises() do
		Event.find(3)
	end
    
  end
  
  # Constraint deleted with task is deleted
  test "constraint deleted with task deletion" do

    authToken = sign_in_api_user(users(:user_task_wtaskconstraint).email)

    route = "/task/" + tasks(:task_constraint).id.to_s

    delete route, 
      headers: { 'Authorization': authToken }

    assert_response :success

    assert_raises() do
      Constraint.find(1)
    end

    assert_raises() do
      Task.find(tasks(:task_constraint).id)
    end
  end

  # Update a task title
  test "update a task title" do

    authToken = sign_in_api_user(users(:user_1task_noEvents).email)
    theNewTitle = "This is the new task title"
    # origCategory = tasks(:task_noEvents).category
    # origPriority = tasks(:task_noEvents).priority

    route = "/task/3" 

    patch route,
      headers: { 'Authorization': authToken },
      params: { task: { title: theNewTitle  } }

    assert_response :success

    assert_equal(theNewTitle, tasks(:task_noEvents).title)
    # assert_equal origCategory, tasks(:task_noEvents).category
    # assert_equal origPriority, tasks(:task_noEvents).priority
  end

  # Update a task category
  test "update a task category" do

    authToken = sign_in_api_user(users(:user_1task_noEvents).email)
    newCategory = 3
    # origCategory = tasks(:task_noEvents).category
    # origPriority = tasks(:task_noEvents).priority

    route = "/task/3" 

    patch route,
      headers: { 'Authorization': authToken },
      params: { task: { category: newCategory } }

    assert_response :success

    assert_equal(newCategory, tasks(:task_noEvents).category)
  end
  # UPdate a task priority
  test "update a task priority" do

    authToken = sign_in_api_user(users(:user_1task_noEvents).email)
    newpriority = 3
    # origpriority = tasks(:task_noEvents).priority
    # origPriority = tasks(:task_noEvents).priority

    route = "/task/3" 

    patch route,
      headers: { 'Authorization': authToken },
      params: { task: { priority: newpriority } }

    assert_response :success

    assert_equal(newpriority, tasks(:task_noEvents).priority)
  end
  # Update a task title, category
  test "update a task title, category" do

    authToken = sign_in_api_user(users(:user_1task_noEvents).email)
    newcategory = 3
    newTitle = "This is the new title!"
    # origcategory = tasks(:task_noEvents).priority
    # origcategory = tasks(:task_noEvents).priority

    route = "/task/3" 

    patch route,
      headers: { 'Authorization': authToken },
      params: { task: { title: newTitle, category: newcategory } }

    assert_response :success

    assert_equal(newcategory, tasks(:task_noEvents).category)
    assert_equal(newTitle, tasks(:task_noEvents).title)
  end
  # Update a task title, priority
  test "update a task title, priority" do

    authToken = sign_in_api_user(users(:user_1task_noEvents).email)
    newpriority = 3
    newTitle = "This is the new title!"
    # origpriority = tasks(:task_noEvents).priority
    # origpriority = tasks(:task_noEvents).priority

    route = "/task/3" 

    patch route,
      headers: { 'Authorization': authToken },
      params: { task: { title: newTitle, priority: newpriority } }

    assert_response :success

    assert_equal(newpriority, tasks(:task_noEvents).priority)
    assert_equal(newTitle, tasks(:task_noEvents).title)
  end
  # Update a task category, priority
  test "update a task category, priority" do

    authToken = sign_in_api_user(users(:user_1task_noEvents).email)
    newpriority = 3
    newcategory = 5 
    # origpriority = tasks(:task_noEvents).priority
    # origpriority = tasks(:task_noEvents).priority

    route = "/task/3" 

    patch route,
      headers: { 'Authorization': authToken },
      params: { task: { category: newcategory, priority: newpriority } }

    assert_response :success

    assert_equal(newpriority, tasks(:task_noEvents).priority)
    assert_equal(newcategory, tasks(:task_noEvents).category)
  end
  # Update a a title, priority, and category
  test "update a task title, category, priority" do

    authToken = sign_in_api_user(users(:user_1task_noEvents).email)
    newpriority = 3
    newcategory = 5 
    newtitle = "This is the new task title!"
    # origpriority = tasks(:task_noEvents).priority
    # origpriority = tasks(:task_noEvents).priority

    route = "/task/3" 

    patch route,
      headers: { 'Authorization': authToken },
      params: { task: { title: newtitle, category: newcategory, priority: newpriority } }

    assert_response :success

    assert_equal(newpriority, tasks(:task_noEvents).priority)
    assert_equal(newcategory, tasks(:task_noEvents).category)
    assert_equal(newtitle, tasks(:task_noEvents).title)
  end
  # Update a non-existing Task (ERROR)
  test "update a non-existant task" do

    authToken = sign_in_api_user(users(:user_1task_noEvents).email)
    newpriority = 3
    newcategory = 5 
    newtitle = "This is the new task title!"
    # origpriority = tasks(:task_noEvents).priority
    # origpriority = tasks(:task_noEvents).priority

    route = "/task/9999" 

    assert_raises() do
      patch route,
        headers: { 'Authorization': authToken },
        params: { task: { title: newtitle, category: newcategory, priority: newpriority } }
    end
  end



end
