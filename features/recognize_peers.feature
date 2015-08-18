Feature: Recognizing peers with badges for demonstrated knowledge

  Background:
    Given I populate db with school of "chucknorris"
    And I visit the home page
    And I login as "e.hoover@foo.com"
    And I follow "Profile"
    And I see only the listed users within subheading "Peers":
      |content|
      |Young Grasshopper|
      |Lisa|
      |Milhouse|
    And I follow "Dashboard"
    And I see 7 peers listed
    And I select "Learn Location of Chuck Norris" next to listed peer "Young Grasshopper"

  Scenario: Listings go away
    And I wait 1 second
    Then I see that "Learn Location of Chuck Norris" is not an option next to listed peer "Young Grasshopper"

  Scenario: Peers can get points repeatedly
    And I select "Penguin Kung Fu" next to listed peer "Young Grasshopper"
    And I select "Penguin Kung Fu" next to listed peer "Young Grasshopper"
    And I select "Penguin Kung Fu" next to listed peer "Young Grasshopper"
    And I follow "Sign out"
    And I login as "yg@foo.com"
    And I follow "Profile"
    And I see "130 points"

  Scenario: Won't error to re-recognize an achievement
    And I wait 1 second
    Then I see that "Learn Location of Chuck Norris" is not an option next to listed peer "Young Grasshopper"
    When I select "Learn Location of Chuck Norris" within subheading "Recognize Peers"
    And I press "Recognize All Peers"
    And I wait 1 second
    Then I see that "Learn Location of Chuck Norris" is not an option next to listed peer "Young Grasshopper"
    And I wait 1 second
    Then I see that "Learn Location of Chuck Norris" is not an option next to listed peer "Milhouse"
