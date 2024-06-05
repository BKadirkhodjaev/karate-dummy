Feature: Todos

  Background:
    * url baseUrl
    * print karate.info.scenarioName

    * def globalTodoUserId = 1001
    * def globalTodoId = 10001
    * def globalTodoTitle = 'test title please ignore 1001 (from variables)'
    * def globalTodoCompleted = false

    * def uuid = function() { return java.util.UUID.randomUUID() + '' }

  @Positive
  Scenario: Create todos
    * def titleAdditional1 = 'title-additional-1'
    * def titleAdditional2 = 'title-additional-2'
    * def titleOptional = 123

    * table todosTable
      | userId           | id           | title                           | completed           |
      | 1000             | 10000        | 'test title please ignore 1000' | true                |
      | globalTodoUserId | globalTodoId | globalTodoTitle                 | globalTodoCompleted |
      | 1002             | 10002        | 'test title please ignore 1002' | true                |
      | 1003             | 10003        | 'test title please ignore 1003' | true                |

    * print "=== Prepared a todos table: ", todosTable

    * def result = call read('reusable/create_todo.feature') todosTable
    * def createdTodos = $result[*].response

    * print "=== Created todos: ", createdTodos
    * print "=== Expected todos length: ", todosTable.length
    * print "=== Actual todos length: ", createdTodos.length

    * match Number(createdTodos.length) == Number(todosTable.length)

  @Positive
  Scenario: Create todos (single)
    * def titleAdditional1 = 'title-additional-1'
    * def titleAdditional2 = 'title-additional-2'
    * def titleOptional = 123
    * def generatedId = karate.get('id', uuid())

    * print 'Generated id: ', generatedId

    * table todosTable
      | userId           | id           | title                           | completed           |
      | 1000             | 10000        | 'test title please ignore 1000' | true                |
      | globalTodoUserId | globalTodoId | globalTodoTitle                 | globalTodoCompleted |
      | 1002             | 10002        | 'test title please ignore 1002' | true                |
      | 1003             | 10003        | 'test title please ignore 1003' | true                |

    * print "=== Prepared a todos table: ", todosTable

    * def createTodo =
      """
      function (array) {
        for (var i = 0; i < array.length; i++) {
          karate.call('reusable/create_todo_single.feature',
            {
              userId: array[i].orderId,
              id: array[i].id,
              title: array[i].title,
              completed: array[i].completed
            })
        }
      }
      """

    * def v = call createTodo todosTable

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

    * def v = call read('reusable/set_json.feature') jsonArray

    * print '=== Final json Object: ', jsonObject