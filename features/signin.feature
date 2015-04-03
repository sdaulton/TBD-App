Feature: Sign in to Account
    As a user
    So that I can use the application through my account
    I want to be able to sign in to my account

Background: The user already exists
    Given these users:
        | name        | email                | password  |
        | Sam Daulton | sdaulton@colgate.edu | easyguess |

    Scenario: Login
        Given I am on the home page
        When I press "Login"
        Then I should be on the users login page
        When I fill in the following:
        | Email    | sdaulton@colgate.edu  | 
        | Password | easyguess             |
        And I press "Log in"
        And I should see "Welcome Sam Daulton!"
