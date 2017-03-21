Feature: Admin Initiated Password Reset
  User requests admin to reset the password to an OTP on behalf of them so the user can reset it to a new password.

  Scenario: Admin resets the password of non admin user with email link
    Given admin user is on password reset page of non admin user
    When admin user resets the password with email option
    Then non admin user should receive an email link

  Scenario: Admin resets the password of non admin user with OTP
    Given admin user is on password reset page of non admin user
    When admin user resets the password with OTP option
    Then one time password should be generated

  Scenario: User account should be locked after admin resets password with email link
    Given admin user has reset the password of non admin user with email link
    When non admin user tries to login with old password
    Then non admin user account should be locked

  Scenario: User account should be locked after admin resets password with OTP
    Given admin user has reset the password of non admin user with OTP
    When non admin user tries to login with old password
    Then non admin user account should be locked

  Scenario: Non admin user resets the password via email link
    Given admin user has reset the password of non admin user with email link
    When non admin user clicks the link
    And resets the password
    Then password should be successfully updated

  Scenario: Non admin user resets the password via OTP
    Given admin user has reset the password of non admin user with OTP
    When non admin user logs in with OTP
    And resets the password
    Then password should be successfully updated

  Scenario: Non admin user logs in after resetting the password via email link
    Given non admin user has updated the password via email link
    And non admin user is on login page
    When non admin types username and new password
    And click on login button
    Then non admin user should be logged in

  Scenario: Non admin user logs in after resetting the password via OTP
    Given non admin user has updated the password via OTP
    And non admin user is on login page
    When non admin user types username and new password
    And click on login button
    Then non admin user should be logged in




