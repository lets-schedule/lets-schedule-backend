require "test_helper"

class TaskControllerTest < ActionDispatch::IntegrationTest
   test "the truth" do
     assert true
   end
   
=begin
   test "task should have title and user_id" do
     @task = Task.new
     assert_not @task.save, "Saved task without title and user_id"
   end
   
   test "task create" do
     @task = Task.create(:name => "task", :priority => 1, :category => 1)
     tid = @task.id
     assert_equal(Task.find(tid), @task)
   end
   
   test "task destroy" do
     @task = Task.create(:name => "task", :priority => 1, :category => 1)
     tid = @task.id
     assert_equal(Task.find(tid), @task)
     Task.destroy(tid)
     assert_raise(Exception) {Task.find(tid)}
   end
=end
   
end
