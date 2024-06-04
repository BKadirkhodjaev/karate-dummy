Feature: Todos

  Background:
    * url baseUrl
    * print karate.info.scenarioName
    * def specialTodoUserId = 1001
    * def specialTodoId = 10001
    * def specialTodoTitle = 'test title please ignore 1001 (from variables)'
    * def specialTodoCompleted = false

  @Positive
  Scenario: Create todos
    * def additional1 = 'a'
    * def additional2 = 'b'
    * table todosTable
      | userId            | id            | title                           | completed            |
      | 1000              | 10000         | 'test title please ignore 1000' | true                 |
      | specialTodoUserId | specialTodoId | specialTodoTitle                | specialTodoCompleted |
      | 1002              | 10002         | 'test title please ignore 1002' | true                 |
      | 1003              | 10003         | 'test title please ignore 1003' | true                 |
    * print "=== Prepared a todos table: ", todosTable
    * def result = call read('reusable/create_todo.feature') todosTable
    * def createdTodos = $result[*].response
    * print "=== Created todos: ", createdTodos
    * print "=== Expected todos length: ", todosTable.length
    * print "=== Actual todos length: ", createdTodos.length
    * match Number(createdTodos.length) == Number(todosTable.length)

  @ignore
  @Positive
  Scenario: Set a json object with fields
    * def jsonObject = {}
    * table jsonArray
      | id | name    |
      | 1  | 'Mike'  |
      | 2  | 'Steve' |
      | 3  | 'Kane'  |
    * print "=== Prepared json array: ", jsonArray
    * print '=== Initial json Object: ', jsonObject
    * call read('reusable/set_json.feature') jsonArray
    * print '=== Final json Object: ', jsonObject