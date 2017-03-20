Feature: LoginFeature
  This is the Publisher Login Feature for APIM : As an API Publisher I want to Login to the Publisher

  Scenario: Login with correct username and password
    Given I'm on API Publisher login page
    When I enter the username as "admin" and "password" as admin
    And click login button
    Then I should see the publisher page

  @datadrivenTest
  Scenario Outline: Login with Correct credentials
    Given I'm on API Publisher login page
    And I enter <username> and <password>
    And click login button
    Then I should see the publisher page

    Examples:
      | username       | password  |
      | admin          | admin     |
      | admin123       | admin@123 |
      | admin@wso2.com | admin123  |