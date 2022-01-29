import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
fileprivate func runNPM(_ app: Application, _ npmURL: URL, _ arguments: [String]) throws {
  let process = Process()
  process.currentDirectoryURL = URL(fileURLWithPath: app.directory.workingDirectory).appendingPathComponent("Web")
  process.executableURL = npmURL
  process.arguments = arguments
  try process.run()
  process.waitUntilExit()
}

public func configure(_ app: Application) throws {
  // uncomment to serve files from /Public folder
  
  let arguments = ["install"]
  let npmURL = URL(fileURLWithPath: "/Users/leo/.nvm/versions/node/v14.18.1/bin/npm")
  try runNPM(app, npmURL, arguments)
  try runNPM(app, npmURL, ["run", "dev"])
  app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory, defaultFile: "index.html"))

//  app.databases.use(.postgres(
//    hostname: Environment.get("DATABASE_HOST") ?? "localhost",
//    port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? PostgresConfiguration.ianaPortNumber,
//    username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
//    password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
//    database: Environment.get("DATABASE_NAME") ?? "vapor_database"
//  ), as: .psql)
//
//  app.migrations.add(CreateTodo())

  // register routes
  try routes(app)
}
