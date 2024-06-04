@ignore
Feature: Create multiple todos (Reusable)
  # Parameter: userId, id, title, completed

  Background: createTodos
    * url baseUrl
    * print karate.info.scenarioName

  Scenario: Create a single todo
    * def finalTitle = title + ' - ' + titleOptional
    * def payload =
      """
      {
        "userId": '#(userId)',
        "id": '#(id)',
        "title": '#(finalTitle)',
        "completed": '#(completed)'
      }
      """

    * print "=== Single payload: ", payload

    Given path '/todos'
    And request payload
    When method post
    Then status 201