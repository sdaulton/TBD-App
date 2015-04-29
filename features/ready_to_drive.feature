Feature: Ready to Drive
    As a driver
    So that I can start to accept requests
    I want to the application to know that I am available to offer rides

    Background: Users in the database
        Given these users:
            | name        | email                  | password  | id | birthday   | is_driving |
            | Sam Daulton | sdaulton@colgate.edu   | guesswhat | 1  | 12/01/1991 | 1          |

        Scenario: Sam becomes ready to drive
            Given I am user 1 on the welcome page
            And I press "Ready to Drive!"
            Then I should be user 1 driver 1 on the driver wait page
            And I should see "You are now waiting for ride requests"
            And I should see "Number of drivers waiting ahead of you: 0"
            When I press "I'm Done Waiting."
            Then I should be user 1 on the welcome page

