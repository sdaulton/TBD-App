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
            And I should see "You are now waiting for an available driver"
            And I should see "Number of drivers currently working: 0"
            And I should see "Number of ride requests ahead of yours: 0"
            When I press "I'm Done Waiting."
            Then I should be user 1 on the welcome page

