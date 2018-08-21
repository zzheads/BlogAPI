import Vapor
import FluentSQLite

/// Creates an instance of Application. This is called from main.swift in the run target.
public func app(_ env: Environment) throws -> Application {
    var config = Config.default()
    var env = env
    var services = Services.default()
    try configure(&config, &env, &services)
    let app = try Application(config: config, environment: env, services: services)
    try boot(app)
    
    
    let users = [
        User(email: "user1@gmail.com", password: "password1"),
        User(email: "user2@gmail.com", password: "password2"),
        User(email: "user3@gmail.com", password: "password3"),
        User(email: "user4@gmail.com", password: "password4"),
        ]
    _ = users.save(in: app).do { _ in
        print("Users saved")
        
        let firstUser = users[0]
        
        let posts = [
            Post(userId: firstUser.id!, text: "First post from user \(firstUser.email)"),
            Post(userId: firstUser.id!, text: "Second post from user \(firstUser.email)"),
            Post(userId: firstUser.id!, text: "Third post from user \(firstUser.email)"),
            Post(userId: firstUser.id!, text: "Fourth post from user \(firstUser.email)"),
            ]
        _ = posts.save(in: app).do { _ in
            print("Posts saved")
        }
    }
    
    return app
}

