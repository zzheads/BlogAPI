import Vapor
import FluentSQLite

public func routes(_ router: Router) throws {
    router.get("users", use: Controller<User>().getAll)
    router.get("users", Int.parameter, use: Controller<User>().get)
    router.post("users", use: Controller<User>().create)
    router.delete("users", Int.parameter, use: Controller<User>().delete)
    router.get("users", Int.parameter, "posts", use: Controller<User>().getPosts)
    router.get("users", Int.parameter, "comments", use: Controller<User>().getComments)
    
    router.get("posts", use: Controller<Post>().getAll)
    router.get("posts", Int.parameter, use: Controller<Post>().get)
    router.post("posts", use: Controller<Post>().create)
    router.delete("posts", Int.parameter, use: Controller<Post>().delete)
    router.get("posts", Int.parameter, "comments", use: Controller<Post>().getComments)
    
    router.get("comments", use: Controller<Comment>().getAll)
    router.get("comments", Int.parameter, use: Controller<Comment>().get)
    router.post("comments", use: Controller<Comment>().create)
    router.delete("comments", Int.parameter, use: Controller<Comment>().delete)
}
