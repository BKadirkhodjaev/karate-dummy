@ignore
Feature: Create multiple todos (Reusable)
  # Parameter: todosTable

  Background: createTodos
    * url baseUrl
    * print karate.info.scenarioName

    * def titleOptionalIfExists = karate.get('titleOptional', null)
    * def titleOptional = titleOptionalIfExists != '#notnull' ? titleOptionalIfExists : -1

  Scenario: Create a single todo
    * print "=== Loop: ", __loop
    * print "=== Arg: ", __arg
    * print "=== Additional title 1: ", titleAdditional1
    * print "=== Additional title 2: ", titleAdditional2

    * if (titleOptional != -1) karate.log("[direct print] === Optional title: ", titleOptional)
    * if (titleOptional != -1) karate.set('titleOptionalDirect', titleOptional)

    * print titleOptionalDirect

    * match __arg == todosTable[__loop]

    * def finalTitle = title + ' - ' + titleAdditional1 + ' - ' + titleAdditional2 + ' - ' + titleOptional
    * def payload =
      """
      {
        "userId": '#(userId)',
        "id": '#(id)',
        "title": '#(finalTitle)',
        "completed": '#(completed)'
      }
      """

    Given path '/todos'
    And request payload
    When method post
    Then status 201