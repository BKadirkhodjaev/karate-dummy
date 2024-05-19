Feature: Todos

  Background:
    * url baseUrl
    * print karate.info.scenarioName
    * def specialDudeTodoUserId = 1001
    * def specialDudeTodoId = 10001
    * def specialDudeTodoTitle = 'test title please ignore 1001 (from variables)'
    * def specialDudeTodoCompleted = false

  @Positive
  Scenario: Create todos
    * table todosTable
      | userId                | id                | title                           | completed                |
      | 1000                  | 10000             | 'test title please ignore 1000' | true                     |
      | specialDudeTodoUserId | specialDudeTodoId | specialDudeTodoTitle            | specialDudeTodoCompleted |
      | 1002                  | 10002             | 'test title please ignore 1002' | true                     |
      | 1003                  | 10003             | 'test title please ignore 1003' | true                     |
    * print "=== Prepared a todos table: ", todosTable
    * def result = call read('reusable/create_todo.feature') todosTable
    * def createdTodos = $result[*].response
    * print "=== Created todos: ", createdTodos
    * print "=== Expected todos length: ", todosTable.length
    * print "=== Actual todos length: ", createdTodos.length
    * match Number(createdTodos.length) == Number(todosTable.length)
