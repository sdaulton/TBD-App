Feature: Update an account
    As a user,
    So that I can have accurate account information
    I want to be able to change my account information

Background: Users in the database
    Given these users:
        | name        | email                  | password  | id | birthday   |
        | Sam Daulton | sdaulton@colgate.edu   | guesswhat | 1  |            |
        | John Test   | jtest@colgate.edu      | guesswhat | 2  | 11/04/1989 |
    Scenario: Initialize a rider only account
        Given I am user 1 on the welcome page
        And I press "View Account"
        Then I should be user 1 on the edit page
        And I select "Just Ride" from "Is driver"    
        When I press "Update user"
        Then I should see "Sam Daulton was successfully updated"
        And I should see "Welcome back, Sam Daulton!"

    Scenario: User account already initialized
        Given I am user 2 on the welcome page
        And I press "View Account"
        Then I should be user 2 on the edit page
        And I fill in "Birthday" with "12/12/1912" 
        And I select "Just Ride" from "Is driver"    
        When I press "Update user"
        Then I should see "John Test was successfully updated"
        And I should see "Welcome back, John Test!"


