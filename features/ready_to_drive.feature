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
            And I should see "You're waiting for ride requests"
            And I should see "There are 0 drivers waiting to pick up people ahead of you"
            When I press "I'm Done Waiting."
            Then I should be user 1 on the welcome page

