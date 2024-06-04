@ignore
Feature: Set Json (Reusable)
  # Parameters:

  Scenario: Set Json
    * set jsonObject.id = __arg.id
    * set jsonObject.name = __arg.name
    * print "=== Some data: ", { "id": jsonObject.id, "name": jsonObject.name }

