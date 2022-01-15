import Fluent
import Vapor

func routes(_ app: Application) throws {
  app.get { _ in
    "It works!"
  }

  app.get("hello") { _ -> String in
    "Hello, world!"
  }

  try app.register(collection: TodoController())
}
