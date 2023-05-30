@Smoke @Regression
Feature: API Test Accounts

  Background: Setup Test Generate Token
    * def tokenFeature = callonce read('GenerateToken.feature')
    * def token = tokenFeature.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Create Account with Random Email
    # Call Java Class and Method with Karate.
    * def dataGenerator = Java.type('api.data.GenerateData')
    * def autoEmail = dataGenerator.getEmail()
    Given path "/api/accounts/get-all-accounts"
    And header Authorization = "Bearer " + token
    And request
      """
      "email": "#(autoEmail)",
      "title": "Mr.",
      "gender": "MALE",
      "firstName": "Saqib", 
      "lastName": "Sadaat",
      "maritalStatus": "Merriad",
      "employmentStatus": "Software Tester",
      "dateOfBirth": "1985-09-05"
      """
    When method post
    Then status 201
    And print response
    And assert response.email == autoEmail
