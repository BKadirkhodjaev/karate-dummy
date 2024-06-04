@ignore
Feature: Create multiple todos (Reusable)
  # Parameter:
  # todosTable

  Background:
    * url baseUrl
    * print karate.info.scenarioName

  Scenario: Create a single todo
    * match __arg == todosTable[__loop]
    * def finalTitle = title + ' - ' +  additional1 + ' - ' + additional2
    * def payload =
    """
    {
      "userId": #(userId),
      "id": #(id),
      "title": #(finalTitle),
      "completed": #(completed)
    }
    """
    Given path '/todos'
    And request payload
    When method post
    Then status 201