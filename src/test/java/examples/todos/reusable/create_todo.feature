@ignore
Feature: Create multiple todos (Reusable)

  Background:
    * url baseUrl
    * print karate.info.scenarioName

  Scenario: Create a single todo
    * match __arg == todosTable[__loop]
    * print "=== Create a single todo for entry: ", __arg
    Given path '/todos'
    And request
    """
    {
      "userId": #{userId},
      "id": #{id},
      "title": #{title},
      "completed": #{completed}
    }
    """
    When method post
    Then status 201