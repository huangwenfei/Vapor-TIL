
import FluentPostgreSQL
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    /// Register providers first
    try services.register(FluentPostgreSQLProvider())

    /// Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    /// Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    /// middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    // 1
    var databases = DatabasesConfig()
    // 2
    /// "??" is meaning: https://stackoverflow.com/questions/47362914/what-is-the-meaning-of-in-swift
    // TODO: Fatal error: Error raised at top level: NIO.ChannelError.connectFailed(NIO.NIOConnectionError(host: "localhost", port: 5432, dnsAError: nil, dnsAAAAError: nil, connectionErrors: [NIO.SingleConnectionFailure(target: [IPv6]localhost/::1:5432, error: connection reset (error set): Connection refused (errno: 61)), NIO.SingleConnectionFailure(target: [IPv4]localhost/127.0.0.1:5432, error: connection reset (error set): Connection refused (errno: 61))]))
    // FIX: URL(https://forums.raywenderlich.com/t/chapter-6-postgressql-docker-error/59605) 要删除 docker container ls -a, docker container rm xxx 删除所有的 Container，重新 docker run --name postgres -e POSTGRES_DB=vapor -e POSTGRES_USER=vapor -e POSTGRES_PASSWORD=password -p 5432:5432 -d postgres 就可以了，重新查看 docker ps [docker start postgres]
    let hostname = Environment.get("DATABASE_HOSTNAME") ?? "localhost"
    let username = Environment.get("DATABASE_USER") ?? "vapor"
    let databaseName = Environment.get("DATABASE_DB") ?? "vapor"
    let password = Environment.get("DATABASE_PASSWORD") ?? "password"
    // 3
    let databaseConfig = PostgreSQLDatabaseConfig(
        hostname: hostname,
        username: username,
        database: databaseName,
        password: password)
    // 4
    let database = PostgreSQLDatabase(config: databaseConfig)
    // 5
    databases.add(database: database, as: .psql)
    // 6
    services.register(databases)

    /// Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: Acronym.self, database: .psql)
    services.register(migrations)

}
