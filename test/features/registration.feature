Feature: User registration
  User registration using existing registered email is not allowed

  Scenario: Signing up using existing email
    Given I have registered using "joe@email.com"
    When I'm signing up using "joe@email.com"
    Then I shouldn't be able to do so