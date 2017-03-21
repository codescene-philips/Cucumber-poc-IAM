Feature: Password Update
  Test cases related to password update functionality


  Scenario: IAM-4:User updates the password successfully
    Given user is on change password page
    When user types "currentPassword" in "currentpasswordfield"
    And user types "newPassword" in "newpasswordfield"
    And user types "newPassword" in "confirmpasswordfield"
    And user clicks "save" button
    Then newpassword should get saved
    And user should be prompted to invalidate all the existing sessions

  Scenario:  IAM-18:User invalidates current sessions after a successful password update
    Given user has already updated the password successfully
    When user clicks on "yes" to invalidate the sessions
    Then password should be updated successfully
    And user should be logged out from the portal

  Scenario: IAM-101:User declines the invalidation of current sessions after a successful password update
    Given user has already update the password successfully
    When user clicks on "no" to invalidate the sessions
    Then password should be updated successfully
    And user should remain on update password page

  @datadriventest
  Scenario Outline: IAM-13:User updates the password with invalid data
    Given user is on change password page
    When user types "currentPassword" in "currentpasswordfield"
    And user types <InvalidPassword> in "newpasswordfield"
    And user types <InvalidPassword> in "confirmpasswordfield"
    And user clicks "save" button
    Then error message should be displayed

    Examples:
      | InvalidPassword             |
      |                             |
      | 1234                        |
      | qwer                        |
      | qwertyuiopasdfghjklzxcvbnm  |
      | @!#$&                       |

  @datadriventest
  Scenario Outline: IAM-35:User updates the password as mismatching entries are for the new password
    Given user is on change password page
    When user types "currentPassword" in "currentpasswordfield"
    And user types <newPassword> in "newpasswordfield"
    And user types <confirmPassword> in "confirmpasswordfield"
    And user clicks "save" button
    Then validation error should be displayed

    Examples:
      | newPassword | confirmPassword |
      | 12@Administrator  | Administrator@12  |
      | Tester@1234 | tester@1234 |
      | Aa@12345678 | Aa#12345678 |


  @datadriventest
  Scenario Outline: IAM-36:User successfully updates the password after correcting invalid data
    Given user has typed an incorrect password in "currentpasswordfield"
    And clicks "save" button
    When user types <currentpassword> in "currentpasswordfield"
    And user types <newPassword> in "newpasswordfield"
    And user types <newPassword> in "confirmpasswordfield"
    And user clicks "save" button
    Then password should be successfully updated

    Examples:
      | currentpassword | newPassword |
      | correctP@ssword     | newP@ssword |








