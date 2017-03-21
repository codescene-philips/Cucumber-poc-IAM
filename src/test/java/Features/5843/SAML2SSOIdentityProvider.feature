Feature: Contains the scenarios related to SAML2 SSO Identity Provider

Scenario: IAM-335:Admin configures SAML2 SSO identity provider with minimum required configurations.
  Given admin is on create SP page
  And name is provided
  And SP is given a Public certificate of third party IDP
  And SP is given a Service Provider Entity Id
  And SP is given Identity Provider Entity Id
  And SP is given a SSO URL
  And admin saves the SP
  And non admin user is on login page
  When non admin user types username and password
  And non admin user clicks on login button
  Then user should be successfully logged in
  And SAML response with a signed assertion should be returned

Scenario: IAM-355:Verify the application receives SAML2 assertion receives a valid response when all the IDP configurations are enabled.
  Given the admin is on create SP page
  And the SP is configured with correct claim configurations
  | dialectURL            | Attribute profile     | Subject claim identifier  |
  | [insertvaliddatahere] | [insertvaliddatahere] | [insertvaliddatahere]     |
  And the inbound SAML SSO configs are provided
  | Issuer                | Consumer URLs         | Default Assertion Consumer URL  | NameID format          | Certificate Alias      | Response Signing Algorithm  | Response Digest Algorithm | Enable Response Signing | Enable Signature Validation in Authentication Requests and Logout Requests | Enable Assertion Encryption  | Enable Single Logout  | Enable Attribute Profile |  Include Attributes in the Response Always | Enable Audience Restriction | Enable Recipient Validation | Enable Assertion Query Request Profile  |
  | [insertvaliddatahere] | [insertvaliddatahere] |  [insertvaliddatahere]          |  [insertvaliddatahere] |  [insertvaliddatahere] |  [insertvaliddatahere]      | [insertvaliddatahere]     | true                    | true                                                                       |  true                        | false                 | true                     | [insertvaliddatahere]                      | true                        | true                        | [insertvaliddatahere]                   |
  And the application is registered as an external IDP
  And SP representing the external IDP is configured
  | Enable SAML2 Web SSO  | Default | Service Provider Entity Id                                  | Identity Provider Entity Id     | SSO URL                                                 | Enable Assertion Encryption | Enable Assertion Signing  | Enable Assertion Encryption | Enable Logout | Enable Authentication Response Signing  | Signature Algorithm | Digest Algorithm  | HTTP Binding  | Attribute Consuming Service Index | Enable Force Authentication | Include Public Certificate |  Include Protocol Binding  | Include Authentication Context  | Authentication Context Class  | Authentication Context Comparison | SAML2 Web SSO User ID Location      | Additional Query Parameters |
  | true                  | true    | <entity id of the sp (application) created in external IDP> | <entityID of the external IDP.> | <External identity provider's SAML2 Web SSO URL value>  | true                        | true                      | true                        | false         | true                                    | DSA with SHA1       | MD5               | HTTP-Redirect |                                   | yes                         | true                       |  true                      | Yes                             | Password Protected Transport  | exact                             | User ID found in 'Name Identifier'  | paramName1=value1           |
  And non admin user is on login page
  When non admin user types username and password
  And non admin user clicks on login button
  Then user should be redirected to external IDP login page
  And non admin user should be successfully logged in

Scenario: IAM-368:Configures SAML2 SSO identity provider with response signing and assertion encryption configurations.
  Given the admin is on create SP page
  And the SP is configured with correct configuration
  | Issuer                | Assertion Consumer URLs | Default Assertion Consumer URL  | Enable Assertion Encryption  | Enable Response Signing  | Response Digest Algorithm                   | Response Signing Algorithm                  |
  | [insertvaliddatahere] | [insertvaliddatahere]   | [insertvaliddatahere]           | true                         | true                     | http://www.w3.org/2001/04/xmldsig­more#md5  | http://www.w3.org/2000/09/xmldsig#dsa­sha1  |
  And the application is registered in the external IDP
  And the external IDP is configured with correct configuration
  | Enable SAML2 Web SSO  | Default | Service Provider Entity Id                                    | Identity Provider Entity Id     | SSO URL                                                 | Enable Assertion Encryption | Enable Response Signing | Enable Logout | Signature Algorithm | Digest Algorithm  |
  | true                  | true    | <entity id of the sp (application) created in external IDP>   | <entityID of the external IDP.> | <External identity provider's SAML2 Web SSO URL value>  | true                        | true                    | false         | DSA with SHA1       | MD5               |
  And the non admin user is on application login page
  When non admin user types username and password
  And non admin user clicks on login button
  Then non admin user should be redirected to the third party IDP login page
  And non admin user should be logged in successfully

Scenario: IAM-387:Configures SAML2 SSO identity provider and service provider with incompatible assertion encryption configurations.
  Given the admin is on create SP page
  And the SP is configured with correct configuration
    | Issuer                | Assertion Consumer URLs | Default Assertion Consumer URL  | Enable Assertion Encryption  | Enable Response Signing  |
    | [insertvaliddatahere] | [insertvaliddatahere]   | [insertvaliddatahere]           | true                         | true                     |
  And the application is registered in the external IDP
  And the external IDP is configured with correct configuration
    | Enable SAML2 Web SSO  | Default | Service Provider Entity Id                                    | Identity Provider Entity Id     | SSO URL                                                 | Enable Assertion Encryption | Enable Response Signing | Enable Logout | Signature Algorithm | Digest Algorithm  |
    | true                  | true    | <entity id of the sp (application) created in external IDP>   | <entityID of the external IDP.> | <External identity provider's SAML2 Web SSO URL value>  | false                       | true                    | false         | DSA with SHA1       | MD5               |
  And the non admin user is on application login page
  When non admin user types username and password
  And non admin user clicks on login button
  Then non admin user should not be logged in
  And SAML assertion should be failed

Scenario: IAM-390:Verify authentication requests are signed when authentication request signing is enabled in brokered authentication configurations.
  Given the admin is on create SP page
  And the SP is configured with correct configuration
  | Issuer                | Assertion Consumer URLs | Default Assertion Consumer URL  | Enable Request Signing  |
  |[insertvaliddatahere]  | [insertvaliddatahere]   | [insertvaliddatahere]           | true                    |
  And the application is registered in the external IDP
  And the external IDP is configured with correct configuration
  | Enable SAML2 Web SSO  | Default | Service Provider Entity Id                                  | Identity Provider Entity Id     | SSO URL                                                 | Enable Request Signing  | Enable Logout |
  | true                  | true    | <entity id of the sp (application) created in external IDP> | <entityID of the external IDP.> | <External identity provider's SAML2 Web SSO URL value>  | true                    | false         |
  And the non admin user is on application login page
  When non admin user types username and password
  Then non admin user should be logged in

Scenario: IAM-390:Verify authentication requests are signed when authentication request signing is enabled in brokered authentication configurations.
  Given the admin is on create SP page
  And the SP is configured with correct configuration
    | Issuer                | Assertion Consumer URLs | Default Assertion Consumer URL  | Enable Request Signing  |
    |[insertvaliddatahere]  | [insertvaliddatahere]   | [insertvaliddatahere]           | true                    |
  And the application is registered in the external IDP
  And the external IDP is configured with correct configuration
    | Enable SAML2 Web SSO  | Default | Service Provider Entity Id                                  | Identity Provider Entity Id     | SSO URL                                                 | Enable Request Signing  | Enable Logout |
    | true                  | true    | <entity id of the sp (application) created in external IDP> | <entityID of the external IDP.> | <External identity provider's SAML2 Web SSO URL value>  | false                   | false         |
  And the non admin user is on application login page
  When non admin user types username and password
  Then non admin user should not be logged in
  And non admin user should not be redirected to external IDP login page
