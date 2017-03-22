Feature: Story_5833 - SAML2 SSO Service Provider
  A developer , I must be able to design a SAML2 SSO service provider, so that the configured relying party can be authenticate users from IS using SAML2 SSO protocol

  # Scenario breakdown for  IAM-330 - part A
  Scenario: Verify SAML authentication request from travelocity is directed to IDP
    Given Travelocity registered as service provider with following configuration
    Then I am on Travelocity login page
    And I enter username as "testUser"
    Then I should be directed to IDP login page

  Scenario: Verify SAML2 SSO with minimum required settings
    Given Travelocity registered as service provider with following configuration:
      | Issuer     | ConsumerURL | DefaultConsumerURL |
      | testIssuer | testURL     | testDefaultURL     |
    And User "testUser" should exist in system with password "testPassword"
    When I am on IDP login page
    And I enter username as "testUser" and password as "testPassword"
    Then I should be successfully logged in
    And I should be redirected to Travelocity Application home page
    And  My username "testUser" should be shown as the logged in user


  Scenario: Verify SAML2 SSO with minimum required settings when there's existing active session
    Given Travelocity registered as service provider with following configuration:
      | Issuer     | ConsumerURL | DefaultConsumerURL |
      | testIssuer | testURL     | testDefaultURL     |
    And User "testUser" should exist in system with password "testPassword"
    And MyApp is configured to have SSO with Travelocity
    And I should be already logged in to Travelocity using username "testUser" and password "testPassword"
    When I load MyApp on same browser that has the logged in session to Travelocity
    Then I should be successfully redirected to MyApp home page

  Scenario: Verify SAML2 SSO with wrong issuer
     Given Travelocity registered as service provider with wrong Issuer value as "wrongIssuer"
     And User "testUser" should exist in system with password "testPassword"
     When I am on IDP login page
     And I enter username as "testUser" and password as "testPassword"
     Then I should not be logged in
     And  I should be directed to an error page
     And I should be given the backend error for the login failure

  Scenario: Verify SAML2 SSO with invalid Assertion Consumer URLs
     Given Travelocity registered as service provider with wrong ConsumerURL value as "wrongURL"
     And User "testUser" should exist in system with password "testPassword"
     When I am on IDP login page
     And I enter username as "testUser" and password as "testPassword"
     Then I should not be logged in
     And  I should be directed to an error page
     And I should be given the backend error for the login failure

  #Following scenario related  IAM-295 is incomplete.
  Scenario: Verify SAML2 SSO with empty value for the "Default Assertion Consumer URL"
    Given Travelocity registered as service provider with empty DefaultConsumerURL value
    And User "testUser" should exist in system with password "testPassword"
    When I am on IDP login page
    And I enter username as "testUser" and password as "testPassword"
    Then I should not be logged in
    And  I should be directed to an error page
    And I should be given the backend error for the login failure

  #Scenario breakdown for  IAM-330 part B
  Scenario: Verify application receives a valid SAML2 response when application sends authentication request using HTTP POST binding
  For this scenario the application should be created to use HTTP POST binding when sending authentication requests
    Given Claim mappings between claim dialect of the application and IS native claim dialect is defined in claim-mapping.yaml
    And Travelocity registered as service provider with following claim configurations:
      | DialectUri  | AttributeProfile  | SubjectClaimIdentifier  |
      | testValue   | testValue         | testValue               |
    And Travelocity registered as Service Provider with following:
      | Issuer | ConsumerURL | DefaultAssertionConsumerURL | NameIDformat | CertificateAlias | ResponseSigningAlgorithm | ResponseDigestAlgorithm | EnableResponseSigning | EnableSignatureValidation | EnableAssertionEncryption | EnableSingleLogout | EnableAttributeProfile | IncludeAttributesintheResponseAlways | EnableAudienceRestriction | Audience | EnableRecipientValidation | Recipient | EnableAssertionQueryRequestProfile |
      | test   | test        | test                        | test         | test             | test                     | test                    | true                  | true                      | true                      | false              | true                   | true                                 | true                      | test     | true                      | a1        | true                               |
    And User "testUser" should exist in system with password "testPassword"
    When I am on IDP login page
    And I enter username as "testUser" and password as "testPassword"
    Then I should be successfully logged in
    And I should be redirected to Travelocity Application home page
    And  My username "testUser" should be shown as the logged in user
    And The SAML response should contain the Signatures of the response and assertions
    And The SAML response should contain the Attributes in the specified claims in application's claim dialect
    And The SAML response should contain the Claim selected as 'subject claim identifier' should be set as subject of the assertion
    And The SAML response should contain the Audience restriction with specified audiences
    And The SAML response should contain the Specified recipients

  Scenario Outline: Verify application receives singed response and user is logged in when 'MD5' is selected as digest value
    Given Travelocity registered as service provider with following configuration:
      | Issuer     | ConsumerURL | DefaultConsumerURL | EnableResponseSigning |
      | testIssuer | testURL     | testDefaultURL     | testValue             |
    And Travelocity registered as service provider as "MD5" for Response Digest Algorithm Name and "http://www.w3.org/2001/04/xmldsig­more#md5" as Response Digest Algorithm URI
    And Travelocity registered as service provider as <ResponseSigningAlgorithmName> for Response Signing Algorithm Name and <ResponseSigningAlgorithmURI> as Response Signing Algorithm URI
    And User "testUser" should exist in system with password "testPassword"
    When I am on IDP login page
    And I enter username as "testUser" and password as "testPassword"
    Then I should be successfully logged in
    And I should be redirected to Travelocity Application home page
    And  My username "testUser" should be shown as the logged in user
    Examples:
      | ResponseSigningAlgorithmName | ResponseSigningAlgorithmURI                                 |
      | DSA with SHA1                | http://www.w3.org/2000/09/xmldsig#dsa­sha1                  |
      | ECDSA with SHA1              | http://www.w3.org/2001/04/xmldsig­more#ecdsa­sha1dsa­sha1   |
      | ECDSA with SHA256            | http://www.w3.org/2001/04/xmldsig­more#ecdsa­sha256         |



