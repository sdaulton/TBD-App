Feature: Create a new account
    As a user,
    so that I can request and offer rides
    I want to create an account and save it to the application's database

    Scenario: Create a new rider only account
        Given I am on the create new account page
        When I fill in the following:
            | Name     | John Smith         |
            | Email    | jsmith@colgate.edu |
            | Password | easy               |
            | Birthday | 1/2/1990           |

        And I press "Create Account"
        Then I should be on the welcome page
        And I should see "Account jsmith@colgate.edu created successfully"
        And I should see "Welcome back, John!"
        And I should see "Request a ride"
        And I should see "Report a problem"
        And I should see "Your Account"
        And I should not see "Ready to drive"
        And I press "Your account"
        Then I should be on the account page
        And I should see that the name is "John Smith"
        And I should see that the email is "jsmith@colgate.edu"
        And I should see the birthday is "1/2/1990"
        And I should see the driver's license number is "D12343535352"

    Scenario: Create a new driver/rider account
        Given I am on the create new account page
        When I fill in the following:
            | Name                  | John Smith         |
            | Email                 | jsmith@colgate.edu |
            | Password              | easy               |
            | Birthday              | 1/2/1990           |
            | Driver's License No.  | D12343535352       |
            | License Plate State   | New York           |
            | License Plate No      | 1313               |
            | Make                  | Honda              |
            | Model                 | Fit                | 
            | Year                  | 2007               |
        And I press "Create Account"
        Then I should be on the welcome page
        And I should see "Account jsmith@colgate.edu created successfully"
        And I should see "Welcome back, John!"
        And I should see "Ready to drive"
        And I should see "Request a ride"
        And I should see "Report a problem"
        And I should see "Your Account"
        And I press "Your Account"
        Then I should be on the account page
        And I should see that the name is "John Smith"
        And I should see that the email is "jsmith@colgate.edu"
        And I should see the birthday is "1/2/1990"
        And I should see the driver's license number is "D12343535352"
        And I should see the license plate state is "New York"
        And I should see the license plate number is "1313"
        And I should see the make is "Honda"
        And I should see the model is "Fit"
        And I should see the year is "2007"


    Scenario: Create a new rider without a birthday
        Given I am on the create new account page
        When I fill in the following:
            | Name                  | John Smith         |
            | Email                 | jsmith@colgate.edu |
            | Password              | easy               |
        And I press "Create Account"
        Then I should be on the create new account page
        And I should see "Required: must fill in Birthday"
        And I should see "John Smith"
        And I should see "jsmith@colgate.edu"

