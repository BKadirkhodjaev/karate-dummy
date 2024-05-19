Feature: Users

  Background:
    * print karate.info.scenarioName
    * url 'https://jsonplaceholder.typicode.com'

  @Positive
  Scenario: Get all users and then get the first user by id
    Given path 'users'
    When method get
    Then status 200
    * def first = response[0]
    Given path 'users', first.id
    When method get
    Then status 200

  @Negative
  Scenario: Create a user and then get it by id
    Given url 'https://jsonplaceholder.typicode.com/users'
    And request
    """
      {
        "name": "Test User",
        "username": "testuser",
        "email": "test@user.com",
        "address": {
          "street": "Has No Name",
          "suite": "Apt. 123",
          "city": "Electri",
          "zipcode": "54321-6789"
        }
      }
      """
    When method post
    Then status 201
    * def id = response.id
    * print '=== created id is: ', id
    Given path id
    When method get
    Then status 404
  