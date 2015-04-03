Feature: Create a new account
    As a user,
    so that I can request and offer rides
    I want to create an account and save it to the application's database

    Scenario: Create a new rider only account
        Given I am on the users register page
        And I press "Jump to after signing in with Google"
        And I select "Just Ride" from "Driver"    
        When I press "Update user"
        Then I should see "Tony Tester was successfully updated"
        And I should see "Welcome Tony Tester!"


