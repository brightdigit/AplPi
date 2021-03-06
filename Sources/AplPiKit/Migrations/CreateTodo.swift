import Fluent

struct CreateTodo: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    database.schema("todos")
      .id()
      .field("title", .string, .required)
      .create()
  }

  func revert(on database: Database) -> EventLoopFuture<Void> {
    database.schema("todos").delete()
  }
}
