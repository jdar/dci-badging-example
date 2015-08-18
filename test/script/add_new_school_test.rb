require 'test_helper'

class AddNewSchoolTest < ActionDispatch::IntegrationTest
  test "example data" do
    ENV["SCHOOL_DIR"] = "input/chucknorris"

    assert_difference 'School.count', +1 do
      load "script/add_new_school"
    end
    assert_equal School.maximum("id"), 1
    assert_equal User.maximum("id"), 15

    #validate data 
    school = School.where(name: "Zen Yoga").first
    assert school
    assert school.locations.any?
    assert school.badges.any?
    assert_equal 3, school.default_badges_for_new_users.length
    assert_equal 1, school.badges.tagged_with(["s:achievement","s:default"]).length
    assert_equal 1, school.badges.tagged_with("s:shared").length

    edna = school.users.where(first_name: "Jean-Claude", last_name: "Van Damm").first
    assert edna

    bart = edna.peers.where(first_name: "Young", last_name: "Grasshopper").first
    assert bart
  end
end
