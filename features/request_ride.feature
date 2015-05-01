Feature: Request a ride
    As a rider
    So that I can get a ride to my destination to avoid being cold
    I want to be able put my name is a queue in the application’s database

    Background: Users in the database
        Given these users:
            | name        | email                  | password  | id | birthday   |
            | Sam Daulton | sdaulton@colgate.edu   | guesswhat | 1  | 12/01/1991 |
            | John Test   | jtest@colgate.edu      | guesswhat | 2  | 11/04/1989 |

        Scenario: Sam requests a ride
            Given I am user 1 on the welcome page
            And I press "Request a ride!"
            Then I should be user 1 rider 1 on the rider wait page
            And I should see "You're in line for the next available driver!"
            And I should see "There are 0 drivers working right now, and 0 people requested rides before you"
            When I press "I'm Done Waiting."
            Then I should be user 1 on the welcome page

