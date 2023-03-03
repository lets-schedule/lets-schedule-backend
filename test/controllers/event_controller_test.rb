require "test_helper"

class EventControllerTest < ActionDispatch::IntegrationTest

  # Get /event?filter[]=opp,start/endtime,datetime
  # test startTime < existing 1 event fixture
  test "startTime < existing 1 event fixture" do
    
    # user who has 1 task and 1 event 
    # event startTime < 2023-03-02
    auth_token = sign_in_api_user(users(:user_event_tests_oneEvent).email)

    # date to filter startTime on 
    date_str = "2023-02-25 13:00:00"

    # route 
    route = "/event?filter[]=<,startTime," + date_str

    get route,
      headers: { 'Authorization': auth_token }

    assert_response :success

    assert_equal events(:event_test_event_1).id, JSON.parse(@response.body)[0]["id"]

  end
  # test startTime = existing 1 event fixture
  test "startTime = existing 1 event fixture" do

    # user who has 1 task and 1 event 
    # event startTime < 2023-03-02
    auth_token = sign_in_api_user(users(:user_event_tests_oneEvent).email)

    # date to filter startTime on 
    date_str = "2023-02-24 00:00:00" 

    opp = "="

    # route 
    route = "/event?filter[]=" + opp + ",startTime," + date_str

    puts route

    get route,
      headers: { 'Authorization': auth_token }

    assert_response :success

    puts @response.body

    assert_equal events(:event_test_event_1).id, JSON.parse(@response.body)[0]["id"]
  
  end
  # test startTime > existing 1 event fixture
  test "startTime > existing 1 event fixture" do
    # user who has 1 task and 1 event 
    auth_token = sign_in_api_user(users(:user_event_tests_oneEvent).email)

    # date to filter startTime on 
    date_str = "2023-02-23 00:00:00" 

   opp = ">"

    # route 
    route = "/event?filter[]=" + opp + ",startTime," + date_str

    puts route

    get route,
      headers: { 'Authorization': auth_token }

    assert_response :success

    puts @response.body

    assert_equal events(:event_test_event_1).id, JSON.parse(@response.body)[0]["id"]
  
  end
  # test startTime >= existing 1 event fixture
  test "startTime >= existing 1 event fixture" do
    # user who has 1 task and 1 event 
    auth_token = sign_in_api_user(users(:user_event_tests_oneEvent).email)

    # date to filter startTime on 
    date_str = "2023-02-20 00:00:00" 

    opp = ">="

    # route 
    route = "/event?filter[]=" + opp + ",startTime," + date_str

    puts route

    get route,
      headers: { 'Authorization': auth_token }

    assert_response :success

    puts @response.body

    assert_equal events(:event_test_event_1).id, JSON.parse(@response.body)[0]["id"]
  
  end
  # test startTime <= existing 1 event fixture
  test "startTime <= existing 1 event fixture" do
    # user who has 1 task and 1 event 
    auth_token = sign_in_api_user(users(:user_event_tests_oneEvent).email)

    # date to filter startTime on 
    date_str = "2023-02-25 00:00:00" 

    opp = "<="

    # route 
    route = "/event?filter[]=" + opp + ",startTime," + date_str

    puts route

    get route,
      headers: { 'Authorization': auth_token }

    assert_response :success

    puts @response.body

    assert_equal events(:event_test_event_1).id, JSON.parse(@response.body)[0]["id"]
  
  end
  # test startTime < 2 existing event fixtures
  test "startTime < 2 existing event fixtures" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    # date to filter startTime on 
    date_str = "2023-01-10 00:00:00" 

    opp = "<"

    # route 
    route = "/event?filter[]=" + opp + ",startTime," + date_str

    get route,
      headers: { 'Authorization': auth_token }

    assert_response :success

    response = JSON.parse(@response.body)

    assert_equal events(:event_test_event_2).id, response[0]["id"]
    assert_equal events(:event_test_event_3).id, response[1]["id"]
  
  end
  # test startTime > 2 existing event fixtures
  test "startTime > 2 existing event fixtures" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    # date to filter startTime on 
    date_str = "2023-01-00 00:00:00" 

    opp = ">"

    # route 
    route = "/event?filter[]=" + opp + ",startTime," + date_str

    get route,
      headers: { 'Authorization': auth_token }

    assert_response :success

    response = JSON.parse(@response.body)

    assert_equal events(:event_test_event_2).id, response[0]["id"]
    assert_equal events(:event_test_event_3).id, response[1]["id"]
  
  end
  # test startTime = 1 out of 2 existing event fixtures
  test "startTime = 1 out of 2 existing event fixtures" do
    
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    # date to filter startTime on 
    date_str = "2023-01-05 00:00:00" 

    opp = "="

    # route 
    route = "/event?filter[]=" + opp + ",startTime," + date_str

    get route,
      headers: { 'Authorization': auth_token }

    assert_response :success

    response = JSON.parse(@response.body)

    assert_equal events(:event_test_event_2).id, response[0]["id"]
  
  end
  # test startTime <= 2 existing event fixtures
  test "startTime <= 2 existing event fixtures" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    # date to filter startTime on 
    date_str = "2023-01-06 00:00:00" 

    opp = "<="

    # route 
    route = "/event?filter[]=" + opp + ",startTime," + date_str

    get route,
      headers: { 'Authorization': auth_token }

    assert_response :success

    response = JSON.parse(@response.body)

    assert_equal events(:event_test_event_2).id, response[0]["id"]
    assert_equal events(:event_test_event_3).id, response[1]["id"]
  
  end
  # test startTime >= 2 existing event fixtures
  test "startTime >= 2 existing event fixtures" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    # date to filter startTime on 
    date_str = "2023-01-05 00:00:00" 

    opp = ">="

    # route 
    route = "/event?filter[]=" + opp + ",startTime," + date_str

    get route,
      headers: { 'Authorization': auth_token }

    assert_response :success

    response = JSON.parse(@response.body)

    assert_equal events(:event_test_event_2).id, response[0]["id"]
    assert_equal events(:event_test_event_3).id, response[1]["id"]
  
  end
  # test startTime < 0 existing event fixtures -- return []
  test "startTime < 0 existing event fixtures -- return []" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    # date to filter startTime on 
    date_str = "2023-01-00 00:00:00" 

    opp = "<"

    # route 
    route = "/event?filter[]=" + opp + ",startTime," + date_str

    get route,
      headers: { 'Authorization': auth_token }

    assert_response :success

    assert_equal "[]", @response.body
  
  end
  # test startTime > 0 existing event fixtures -- return []
  test "startTime > 0 existing event fixtures -- return []" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    # date to filter startTime on 
    date_str = "2023-01-10 00:00:00" 

    opp = ">"

    # route 
    route = "/event?filter[]=" + opp + ",startTime," + date_str

    get route,
      headers: { 'Authorization': auth_token }

    assert_response :success

    assert_equal "[]", @response.body
  
  end
  # test startTime = 0 existing event fixtures -- return []
  test "startTime = 0 existing event fixtures -- return []" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    # date to filter startTime on 
    date_str = "2023-01-10 00:00:00" 

    opp = "="

    # route 
    route = "/event?filter[]=" + opp + ",startTime," + date_str

    get route,
      headers: { 'Authorization': auth_token }

    assert_response :success

    assert_equal "[]", @response.body
  
  end
  
  # test endTime < existing 1 event fixture
  test "endTime < existing 1 event fixture" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    # date to filter startTime on 
    date_str = "2023-01-07 00:00:00" 

    opp = "<"

    # route 
    route = "/event?filter[]=" + opp + ",endTime," + date_str

    get route,
      headers: { 'Authorization': auth_token }

    assert_response :success

    assert_equal events(:event_test_event_2).id, JSON.parse(@response.body)[0]["id"]
  
  end
  # test endTime = existing 1 event fixture
  test "endTime = existing 1 event fixture" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    # date to filter startTime on 
    date_str = "2023-01-07 00:00:00" 

    opp = "="

    # route 
    route = "/event?filter[]=" + opp + ",endTime," + date_str

    get route,
      headers: { 'Authorization': auth_token }

    assert_response :success

    assert_equal events(:event_test_event_3).id, JSON.parse(@response.body)[0]["id"]
  
  end
  # test endTime > existing 1 event fixture
  test "endTime > existing 1 event fixture" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    # date to filter startTime on 
    date_str = "2023-01-06 00:00:00" 

    opp = ">"

    # route 
    route = "/event?filter[]=" + opp + ",endTime," + date_str

    get route,
      headers: { 'Authorization': auth_token }

    assert_response :success

    assert_equal events(:event_test_event_3).id, JSON.parse(@response.body)[0]["id"]
  
  end
  # test endTime >= existing 1 event fixture
  test "endTime >= existing 1 event fixture" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    # date to filter startTime on 
    date_str = "2023-01-07 00:00:00" 

    opp = ">="

    # route 
    route = "/event?filter[]=" + opp + ",endTime," + date_str

    get route,
      headers: { 'Authorization': auth_token }

    assert_response :success

    assert_equal events(:event_test_event_3).id, JSON.parse(@response.body)[0]["id"]
  
  end
  # test endTime <= existing 1 event fixture
  test "endTime <= existing 1 event fixture" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    # date to filter startTime on 
    date_str = "2023-01-06 10:00:00" 

    opp = "<="

    # route 
    route = "/event?filter[]=" + opp + ",endTime," + date_str

    get route,
      headers: { 'Authorization': auth_token }

    assert_response :success

    assert_equal events(:event_test_event_2).id, JSON.parse(@response.body)[0]["id"]
  
  end
  # test endTime < 2 existing event fixtures
  test "endTime < 2 existing event fixtures" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    # date to filter startTime on 
    date_str = "2023-01-10 10:00:00" 

    opp = "<"

    # route 
    route = "/event?filter[]=" + opp + ",endTime," + date_str

    get route,
      headers: { 'Authorization': auth_token }

    assert_response :success

    assert_equal events(:event_test_event_2).id, JSON.parse(@response.body)[0]["id"]
    assert_equal events(:event_test_event_3).id, JSON.parse(@response.body)[1]["id"]
  
  end
  # test endTime > 2 existing event fixtures
  test "endTime > 2 existing event fixtures" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    # date to filter startTime on 
    date_str = "2023-01-00 10:00:00" 

    opp = ">"

    # route 
    route = "/event?filter[]=" + opp + ",endTime," + date_str

    get route,
      headers: { 'Authorization': auth_token }

    assert_response :success

    assert_equal events(:event_test_event_2).id, JSON.parse(@response.body)[0]["id"]
    assert_equal events(:event_test_event_3).id, JSON.parse(@response.body)[1]["id"]
  
  end
  # test endTime = 1 of 2 existing event fixtures
  test "endTime = 1 of 2 existing event fixtures" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    # date to filter startTime on 
    date_str = "2023-01-07 00:00:00" 

    opp = "="

    # route 
    route = "/event?filter[]=" + opp + ",endTime," + date_str

    get route,
      headers: { 'Authorization': auth_token }

    assert_response :success

    assert_equal events(:event_test_event_3).id, JSON.parse(@response.body)[0]["id"]
  
  end
  # test endTime <= 2 existing event fixtures
  test "endTime <= 2 existing event fixtures" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    # date to filter startTime on 
    date_str = "2023-01-10 00:00:00" 

    opp = "<="

    # route 
    route = "/event?filter[]=" + opp + ",endTime," + date_str

    get route,
      headers: { 'Authorization': auth_token }

    assert_response :success

    assert_equal events(:event_test_event_2).id, JSON.parse(@response.body)[0]["id"]
    assert_equal events(:event_test_event_3).id, JSON.parse(@response.body)[1]["id"]
  
  end
  # test endTime >= 2 existing event fixtures
  test "endTime >= 2 existing event fixtures" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    # date to filter startTime on 
    date_str = "2023-01-00 00:00:00" 

    opp = ">="

    # route 
    route = "/event?filter[]=" + opp + ",endTime," + date_str

    get route,
      headers: { 'Authorization': auth_token }

    assert_response :success

    assert_equal events(:event_test_event_2).id, JSON.parse(@response.body)[0]["id"]
    assert_equal events(:event_test_event_3).id, JSON.parse(@response.body)[1]["id"]
  
  end
  # test endTime < 0 existing event fixtures -- return []
  test "endTime < 0 existing event fixtures -- return []" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    # date to filter startTime on 
    date_str = "2023-01-00 00:00:00" 

    opp = "<"

    # route 
    route = "/event?filter[]=" + opp + ",endTime," + date_str

    get route,
      headers: { 'Authorization': auth_token }

    assert_response :success

    assert_equal "[]", @response.body
  
  end
  # test endTime > 0 existing event fixtures -- return []
  test "endTime > 0 existing event fixtures -- return []" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    # date to filter startTime on 
    date_str = "2023-01-10 00:00:00" 

    opp = ">"

    # route 
    route = "/event?filter[]=" + opp + ",endTime," + date_str

    get route,
      headers: { 'Authorization': auth_token }

    assert_response :success
    assert_equal "[]", @response.body

  
  end
  # test endTime = 0 existing event fixtures -- return []
  test "endTime = 0 existing event fixtures -- return []" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    # date to filter startTime on 
    date_str = "2023-01-10 00:00:00" 

    opp = "="

    # route 
    route = "/event?filter[]=" + opp + ",endTime," + date_str

    get route,
      headers: { 'Authorization': auth_token }

    assert_response :success

    assert_equal "[]", @response.body
  
  end
  # test endTime >= 0 existing event fixtures -- return []
  test "endTime >= 0 existing event fixtures -- return []" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    # date to filter startTime on 
    date_str = "2023-01-10 00:00:00" 

    opp = ">="

    # route 
    route = "/event?filter[]=" + opp + ",endTime," + date_str

    get route,
      headers: { 'Authorization': auth_token }

    assert_response :success

    assert_equal "[]", @response.body
  
  end
  # test startTime and endTime < existing 1 event fixture
  test "startTime and endTime < existing 1 event fixture" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    # date to filter startTime on 
    date_st = "2023-01-07 00:00:00" 
    date_end = "2023-01-07 00:00:00"

    opp = "<"

    # route 
    begRoute = "/event?"
    route = "filter[]="
    firstOp = opp + ",startTime," + date_st
    secondOp = opp + ",endTime," + date_end
    totRoute = begRoute + route + firstOp + "&" + route + secondOp

    get totRoute,
      headers: { 'Authorization': auth_token }

    assert_response :success

    puts totRoute

    assert_equal events(:event_test_event_2).id, JSON.parse(@response.body)[0]["id"]
  
  end
  # test startTime and endTime = existing 1 event fixture
  test "startTime and endTime = existing 1 event fixture" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    # date to filter startTime on 
    date_st = "2023-01-06 00:00:00" 
    date_end = "2023-01-07 00:00:00"

    opp = "="

    # route 
    route = "/event?"
    firstOp = "filter[]=" + opp + ",startTime," + date_st
    secondOp = "&filter[]=" + opp + ",endTime," + date_end
    totRoute = route + firstOp + secondOp

    get totRoute,
      headers: { 'Authorization': auth_token }

    puts totRoute
    puts "\n\nHere is the response body:"
    puts @response.body

    assert_response :success

    assert_equal events(:event_test_event_3).id, JSON.parse(@response.body)[0]["id"]

  end
  # test startTime and endTime > existing 1 event fixture
  test "startTime and endTime > existing 1 event fixture" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    # date to filter startTime on
    date_st = "2023-01-05 00:00:00" 
    date_end = "2023-01-06 00:00:00"

    opp = ">"

    # route 
    route = "/event?"
    firstOp = "filter[]=" + opp + ",startTime," + date_st
    secondOp = "&filter[]=" + opp + ",endTime," + date_end
    totRoute = route + firstOp + secondOp

    get totRoute,
      headers: { 'Authorization': auth_token }

    assert_response :success
    puts "\n\nresponse:"
    puts @response.body
    puts "\n\n:"

    assert_equal events(:event_test_event_3).id, JSON.parse(@response.body)[0]["id"]

  end
  # # test startTime and endTime >= existing 1 event fixture
  test "startTime and endTime >= existing 1 event fixture" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    # date to filter startTime on
    date_st = "2023-01-06 00:00:00" 
    date_end = "2023-01-06 00:30:00"

    opp = ">="

    # route 
    route = "/event?"
    firstOp = "filter[]=" + opp + ",startTime," + date_st
    secondOp = "&filter[]=" + opp + ",endTime," + date_end
    totRoute = route + firstOp + secondOp

    get totRoute,
      headers: { 'Authorization': auth_token }

    assert_response :success

    assert_equal events(:event_test_event_3).id, JSON.parse(@response.body)[0]["id"]

  end
  # test startTime and endTime <= existing 1 event fixture
  test "startTime and endTime <= existing 1 event fixture" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    # date to filter startTime on
    date_st = "2023-01-06 00:00:00" 
    date_end = "2023-01-06 00:30:00"

    opp = "<="

    # route 
    route = "/event?"
    firstOp = "filter[]=" + opp + ",startTime," + date_st
    secondOp = "&filter[]=" + opp + ",endTime," + date_end
    totRoute = route + firstOp + secondOp

    get totRoute,
      headers: { 'Authorization': auth_token }

    assert_response :success

    assert_equal events(:event_test_event_2).id, JSON.parse(@response.body)[0]["id"]

  end
  # test startTime and endTime < 2 existing event fixtures
  test "startTime and endTime < 2 existing event fixtures" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    # date to filter startTime on
    date_st = "2023-01-10 00:00:00" 
    date_end = "2023-01-10 00:30:00"

    opp = "<"

    # route 
    route = "/event?"
    firstOp = "filter[]=" + opp + ",startTime," + date_st
    secondOp = "&filter[]=" + opp + ",endTime," + date_end
    totRoute = route + firstOp + secondOp

    get totRoute,
      headers: { 'Authorization': auth_token }

    assert_response :success

    assert_equal events(:event_test_event_2).id, JSON.parse(@response.body)[0]["id"]
    assert_equal events(:event_test_event_3).id, JSON.parse(@response.body)[1]["id"]

  end
  # test startTime and endTime > 2 existing event fixtures
  test "startTime and endTime > 2 existing event fixtures" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    # date to filter startTime on
    date_st = "2023-01-00 00:00:00" 
    date_end = "2023-01-00 00:30:00"

    opp = ">"

    # route 
    route = "/event?"
    firstOp = "filter[]=" + opp + ",startTime," + date_st
    secondOp = "&filter[]=" + opp + ",endTime," + date_end
    totRoute = route + firstOp + secondOp

    get totRoute,
      headers: { 'Authorization': auth_token }

    assert_response :success

    assert_equal events(:event_test_event_2).id, JSON.parse(@response.body)[0]["id"]
    assert_equal events(:event_test_event_3).id, JSON.parse(@response.body)[1]["id"]

  end
  # test startTime and endTime = 2 existing event fixtures
  test "startTime and endTime = 2 existing event fixtures" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents_sameStartEndTimes).email)

    # date to filter startTime on
    date_st = "2023-01-10 00:00:00" 
    date_end = "2023-01-10 00:30:00"

    opp = "="

    # route 
    route = "/event?"
    firstOp = "filter[]=" + opp + ",startTime," + date_st
    secondOp = "&filter[]=" + opp + ",endTime," + date_end
    totRoute = route + firstOp + secondOp

    get totRoute,
      headers: { 'Authorization': auth_token }

    assert_response :success

    assert_equal events(:event_test_event_4).id, JSON.parse(@response.body)[0]["id"]
    assert_equal events(:event_test_event_5).id, JSON.parse(@response.body)[1]["id"]

  end
  # test startTime and endTime <= 2 existing event fixtures
  test "startTime and endTime <= 2 existing event fixtures" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    # date to filter startTime on
    date_st = "2023-01-06 00:30:00" 
    date_end = "2023-01-07 00:00:00"

    opp = "<="

    # route 
    route = "/event?"
    firstOp = "filter[]=" + opp + ",startTime," + date_st
    secondOp = "&filter[]=" + opp + ",endTime," + date_end
    totRoute = route + firstOp + secondOp

    get totRoute,
      headers: { 'Authorization': auth_token }

    assert_response :success

    assert_equal events(:event_test_event_2).id, JSON.parse(@response.body)[0]["id"]
    assert_equal events(:event_test_event_3).id, JSON.parse(@response.body)[1]["id"]

  end
  # test startTime and endTime >= 2 existing event fixtures
  test "startTime and endTime >= 2 existing event fixtures" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    # date to filter startTime on
    date_st = "2023-01-04 12:00:00" 
    date_end = "2023-01-06 00:00:00"

    opp = ">="

    # route 
    route = "/event?"
    firstOp = "filter[]=" + opp + ",startTime," + date_st
    secondOp = "&filter[]=" + opp + ",endTime," + date_end
    totRoute = route + firstOp + secondOp

    get totRoute,
      headers: { 'Authorization': auth_token }

    assert_response :success

    assert_equal events(:event_test_event_2).id, JSON.parse(@response.body)[0]["id"]
    assert_equal events(:event_test_event_3).id, JSON.parse(@response.body)[1]["id"]

  end
  # test startTime and endTime < 0 existing event fixtures -- return []
  test "startTime and endTime < 0 existing event fixtures -- return []" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    # date to filter startTime on
    date_st = "2023-01-04 12:00:00" 
    date_end = "2023-01-06 00:00:00"

    opp = "<"

    # route 
    route = "/event?"
    firstOp = "filter[]=" + opp + ",startTime," + date_st
    secondOp = "&filter[]=" + opp + ",endTime," + date_end
    totRoute = route + firstOp + secondOp

    get totRoute,
      headers: { 'Authorization': auth_token }

    assert_response :success

    assert_equal "[]", @response.body

  end
  # test startTime and endTime > 0 existing event fixtures -- return []
  test "startTime and endTime > 0 existing event fixtures -- return []" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    # date to filter startTime on
    date_st = "2023-01-06 00:00:00" 
    date_end = "2023-01-07 00:00:01"

    opp = ">"

    # route 
    route = "/event?"
    firstOp = "filter[]=" + opp + ",startTime," + date_st
    secondOp = "&filter[]=" + opp + ",endTime," + date_end
    totRoute = route + firstOp + secondOp

    get totRoute,
      headers: { 'Authorization': auth_token }

    assert_response :success

    assert_equal "[]", @response.body

  end
  # test startTime and endTime = 0 existing event fixtures -- return []
  test "startTime and endTime = 0 existing event fixtures -- return []" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    # date to filter startTime on
    date_st = "2023-01-06 00:00:01"
    date_end = "2023-01-07 00:00:01"

    opp = "="

    # route 
    route = "/event?"
    firstOp = "filter[]=" + opp + ",startTime," + date_st
    secondOp = "&filter[]=" + opp + ",endTime," + date_end
    totRoute = route + firstOp + secondOp

    get totRoute,
      headers: { 'Authorization': auth_token }

    assert_response :success

    assert_equal "[]", @response.body

  end
  # test startTime and endTime >= 0 existing event fixtures -- return []
  test "startTime and endTime >= 0 existing event fixtures -- return []" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    # date to filter startTime on
    date_st = "2023-01-06 00:00:01"
    date_end = "2023-01-07 00:00:01"

    opp = ">="

    # route 
    route = "/event?"
    firstOp = "filter[]=" + opp + ",startTime," + date_st
    secondOp = "&filter[]=" + opp + ",endTime," + date_end
    totRoute = route + firstOp + secondOp

    get totRoute,
      headers: { 'Authorization': auth_token }

    assert_response :success

    assert_equal "[]", @response.body

  end
  # test 3 filters (fail)
  test "3 filters (fail)" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    # date to filter startTime on
    date_st = "2023-01-07 00:00:00"
    date_end = "2023-01-07 00:00:00"
    date_err = "2023-01-10 00:00:00"

    opp = "<="

    # route 
    route = "/event?"
    firstOp = "filter[]=" + opp + ",startTime," + date_st
    secondOp = "&filter[]=" + opp + ",endTime," + date_end
    errOp = "&filter[]=" + opp + ",startTime," + date_err
    totRoute = route + firstOp + secondOp + errOp

    get totRoute,
      headers: { 'Authorization': auth_token }

    assert_response 400

  end
  # test filter with no argument fail
  test "filter with no argument fail" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    # route 
    route = "/event?filter[]="

    get route,
      headers: { 'Authorization': auth_token }

    assert_response 400

  end
  # test filter with only opp and startTime (fail)
  test "filter with only opp and startTime (fail)" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    date_st = "2023-02-21 00:00:00"
    # route 
    route = "/event?filter[]=<,startTime" 

    get route,
      headers: { 'Authorization': auth_token }

    assert_response 400

  end
  # test filter with only startTime and datetime (fail)
  test "filter with only startTime and datetime (fail)" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    date_st = "2023-02-21 00:00:00"
    # route 
    route = "/event?filter[]=startTime," + date_st 

    get route,
      headers: { 'Authorization': auth_token }

    assert_response 400

  end
  # test filter with 4 comma separated (fail)
  test "filter with 4 comma separated (fail)" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    date_st = "2023-02-21 00:00:00"
    # route 
    route = "/event?filter[]=>startTime," + date_st + ",>"

    get route,
      headers: { 'Authorization': auth_token }

    assert_response 400

  end
  # GET task/{task_id}/event/{id}
  # test 1 fixture exists
  test "1 fixture exists" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    @task = User.find(users(:user_event_tests_twoEvents).id).tasks.first
    @event = @task.events.first

    assert_not_nil @task
    assert_not_nil @event

    route = "/task/" + @task.id.to_s + "/event/" + @event.id.to_s

    get route,
      headers: { 'Authorization': auth_token }

    assert_response :success

    puts route
    puts @response.body
    puts @event.id
    puts @task.id

    assert_equal @event.id, JSON.parse(@response.body)["id"]

  end
  # test no fixture exists (fail)
  test "no fixture exists (fail)" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_1task_noEvents).email)

    @task = User.find(users(:user_1task_noEvents).id).tasks.first
    # route
    route = "/task/" + @task.id.to_s + "/event/1"

    assert_raises() do
      get route,
        headers: { 'Authorization': auth_token }
    end

  end
  # test task_id doesnt exist (fail)
  test "get task_id doesnt exist (fail)" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:james).email)

    route = "/task/1/event/1"

    assert_raises() do
      get route,
        headers: { 'Authorization': auth_token }
    end

  end

  # POST task/{task_id}/event
  # test no startTime error
  test "no startTime error" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    @task = User.find(users(:user_event_tests_twoEvents).id).tasks.first
    @event = @task.events.first

    route = "/task/" + @task.id.to_s + "/event"
    newDate = "2023-03-01 00:00:00"


    assert_raises() do
      post route,
        headers: { 'Authorization': auth_token },
        params: { event: { endTime: newDate } }
    end

  end
  # test duration error
  test "no endTime error" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    # date to filter startTime on
    date_str = "2023-01-10 00:00:00"

    @task = User.find(users(:user_event_tests_twoEvents).id).tasks.first
    # route
    route = "/task/" + @task.id.to_s + "/event"

    assert_raises() do
      post route,
        headers: { 'Authorization': auth_token },
        params: { event: { startTime: date_str }}
    end

  end
  # test succesful creation
  test "succesful creation" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)

    @task = User.find(users(:user_event_tests_twoEvents).id).tasks.first
    # route
    route = "/task/" + @task.id.to_s + "/event"

    # date to filter startTime on
    newStartTime = "2023-01-10 00:00:00"
    newEndTime = "2023-01-10 00:00:01"

    route = "/task/" + @task.id.to_s + "/event"

    post route,
      headers: { 'Authorization': auth_token },
      params: { event: { startTime: newStartTime, endTime: newEndTime }}

    assert_response :success

    assert Date.parse(newStartTime) == Date.parse(JSON.parse(@response.body)["startTime"])
    assert Date.parse(newEndTime) == Date.parse(JSON.parse(@response.body)["endTime"])

  end
  # test returns 1 conflicting event
  test "returns 1 conflicting event" do
    # user who has 2 task and 2 events
    auth_token = sign_in_api_user(users(:user_event_tests_oneEvent).email)

    @task = User.find(users(:user_event_tests_oneEvent).id).tasks.first

    conflictStartTime = "2023-02-24 00:00:00"
    conflictEndTime = "2023-02-24 01:00:00"

    post route,
      headers: { 'Authorization': auth_token },
      params: { event: { startTime: conflictStartTime, endTime: conflictEndTime } }

    assert_response :success

    # TODO Validate conlflicting event

  end
  # # test returns 2 conflicting event
  # test "returns 2 conflicting event" do
  #   # user who has 2 task and 2 events
  #   auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)
  #
  #   # date to filter startTime on
  #   date_str = "2023-01-10 00:00:00"
  #
  #   opp = "<="
  #
  #   # route
  #   route = "/event?filter[]=" + opp + ",endTime," + date_str
  #
  #   get route,
  #     headers: { 'Authorization': auth_token }
  #
  #   assert_response :success
  #
  #   assert_equal events(:event_test_event_2).id, JSON.parse(@response.body)[0]["id"]
  #   assert_equal events(:event_test_event_3).id, JSON.parse(@response.body)[1]["id"]
  #
  # end
  # # DELETE task/{task_id}/event/id
  # # test successful deletion 1 event
  # test "successful deletion 1 event" do
  #   # user who has 2 task and 2 events
  #   auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)
  #
  #   # date to filter startTime on
  #   date_str = "2023-01-10 00:00:00"
  #
  #   opp = "<="
  #
  #   # route
  #   route = "/event?filter[]=" + opp + ",endTime," + date_str
  #
  #   get route,
  #     headers: { 'Authorization': auth_token }
  #
  #   assert_response :success
  #
  #   assert_equal events(:event_test_event_2).id, JSON.parse(@response.body)[0]["id"]
  #   assert_equal events(:event_test_event_3).id, JSON.parse(@response.body)[1]["id"]
  #
  # end
  # test "delete event id DNE (fail)" do
  #   # user who has 2 task and 2 events
  #   auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)
  #
  #   # date to filter startTime on
  #   date_str = "2023-01-10 00:00:00"
  #
  #   opp = "<="
  #
  #   # route
  #   route = "/event?filter[]=" + opp + ",endTime," + date_str
  #
  #   get route,
  #     headers: { 'Authorization': auth_token }
  #
  #   assert_response :success
  #
  #   assert_equal events(:event_test_event_2).id, JSON.parse(@response.body)[0]["id"]
  #   assert_equal events(:event_test_event_3).id, JSON.parse(@response.body)[1]["id"]
  #
  # end
  # # test task_id DNE (fail)
  # test "delete delete task_id DNE (fail)" do
  #   # user who has 2 task and 2 events
  #   auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)
  #
  #   # date to filter startTime on
  #   date_str = "2023-01-10 00:00:00"
  #
  #   opp = "<="
  #
  #   # route
  #   route = "/event?filter[]=" + opp + ",endTime," + date_str
  #
  #   get route,
  #     headers: { 'Authorization': auth_token }
  #
  #   assert_response :success
  #
  #   assert_equal events(:event_test_event_2).id, JSON.parse(@response.body)[0]["id"]
  #   assert_equal events(:event_test_event_3).id, JSON.parse(@response.body)[1]["id"]
  #
  # end
  # # PATCH task/{task_id}/event/{id}
  # # test update startTime success
  # test "update startTime success" do
  #   # user who has 2 task and 2 events
  #   auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)
  #
  #   # date to filter startTime on
  #   date_str = "2023-01-10 00:00:00"
  #
  #   opp = "<="
  #
  #   # route
  #   route = "/event?filter[]=" + opp + ",endTime," + date_str
  #
  #   get route,
  #     headers: { 'Authorization': auth_token }
  #
  #   assert_response :success
  #
  #   assert_equal events(:event_test_event_2).id, JSON.parse(@response.body)[0]["id"]
  #   assert_equal events(:event_test_event_3).id, JSON.parse(@response.body)[1]["id"]
  #
  # end
  # # test update endTime success
  # test "update endTime success" do
  #   # user who has 2 task and 2 events
  #   auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)
  #
  #   # date to filter startTime on
  #   date_str = "2023-01-10 00:00:00"
  #
  #   opp = "<="
  #
  #   # route
  #   route = "/event?filter[]=" + opp + ",endTime," + date_str
  #
  #   get route,
  #     headers: { 'Authorization': auth_token }
  #
  #   assert_response :success
  #
  #   assert_equal events(:event_test_event_2).id, JSON.parse(@response.body)[0]["id"]
  #   assert_equal events(:event_test_event_3).id, JSON.parse(@response.body)[1]["id"]
  #
  # end
  # # test update both success
  # test "update both success" do
  #   # user who has 2 task and 2 events
  #   auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)
  #
  #   # date to filter startTime on
  #   date_str = "2023-01-10 00:00:00"
  #
  #   opp = "<="
  #
  #   # route
  #   route = "/event?filter[]=" + opp + ",endTime," + date_str
  #
  #   get route,
  #     headers: { 'Authorization': auth_token }
  #
  #   assert_response :success
  #
  #   assert_equal events(:event_test_event_2).id, JSON.parse(@response.body)[0]["id"]
  #   assert_equal events(:event_test_event_3).id, JSON.parse(@response.body)[1]["id"]
  #
  # end
  # # test no input
  # test "no input" do
  #   # user who has 2 task and 2 events
  #   auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)
  #
  #   # date to filter startTime on
  #   date_str = "2023-01-10 00:00:00"
  #
  #   opp = "<="
  #
  #   # route
  #   route = "/event?filter[]=" + opp + ",endTime," + date_str
  #
  #   get route,
  #     headers: { 'Authorization': auth_token }
  #
  #   assert_response :success
  #
  #   assert_equal events(:event_test_event_2).id, JSON.parse(@response.body)[0]["id"]
  #   assert_equal events(:event_test_event_3).id, JSON.parse(@response.body)[1]["id"]
  #
  # end
  # # test event_id DNE (fail)
  # test "update event_id DNE (fail)" do
  #   # user who has 2 task and 2 events
  #   auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)
  #
  #   # date to filter startTime on
  #   date_str = "2023-01-10 00:00:00"
  #
  #   opp = "<="
  #
  #   # route
  #   route = "/event?filter[]=" + opp + ",endTime," + date_str
  #
  #   get route,
  #     headers: { 'Authorization': auth_token }
  #
  #   assert_response :success
  #
  #   assert_equal events(:event_test_event_2).id, JSON.parse(@response.body)[0]["id"]
  #   assert_equal events(:event_test_event_3).id, JSON.parse(@response.body)[1]["id"]
  #
  # end
  # # test task_id DNE (fail)
  # test "update task_id DNE (fail)" do
  #   # user who has 2 task and 2 events
  #   auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)
  #
  #   # date to filter startTime on
  #   date_str = "2023-01-10 00:00:00"
  #
  #   opp = "<="
  #
  #   # route
  #   route = "/event?filter[]=" + opp + ",endTime," + date_str
  #
  #   get route,
  #     headers: { 'Authorization': auth_token }
  #
  #   assert_response :success
  #
  #   assert_equal events(:event_test_event_2).id, JSON.parse(@response.body)[0]["id"]
  #   assert_equal events(:event_test_event_3).id, JSON.parse(@response.body)[1]["id"]
  #
  # end
  # # test update and return 1 conflicting event
  # test "update and return 1 conflicting event" do
  #   # user who has 2 task and 2 events
  #   auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)
  #
  #   # date to filter startTime on
  #   date_str = "2023-01-10 00:00:00"
  #
  #   opp = "<="
  #
  #   # route
  #   route = "/event?filter[]=" + opp + ",endTime," + date_str
  #
  #   get route,
  #     headers: { 'Authorization': auth_token }
  #
  #   assert_response :success
  #
  #   assert_equal events(:event_test_event_2).id, JSON.parse(@response.body)[0]["id"]
  #   assert_equal events(:event_test_event_3).id, JSON.parse(@response.body)[1]["id"]
  #
  # end
  # # test update and return 2 conflicting events
  # test "update and return 2 conflicting events" do
  #   # user who has 2 task and 2 events
  #   auth_token = sign_in_api_user(users(:user_event_tests_twoEvents).email)
  #
  #   # date to filter startTime on
  #   date_str = "2023-01-10 00:00:00"
  #
  #   opp = "<="
  #
  #   # route
  #   route = "/event?filter[]=" + opp + ",endTime," + date_str
  #
  #   get route,
  #     headers: { 'Authorization': auth_token }
  #
  #   assert_response :success
  #
  #   assert_equal events(:event_test_event_2).id, JSON.parse(@response.body)[0]["id"]
  #   assert_equal events(:event_test_event_3).id, JSON.parse(@response.body)[1]["id"]
  #
  # end
  #
 end
