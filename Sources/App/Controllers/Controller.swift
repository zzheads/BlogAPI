//
//  Controller.swift
//  App
//
//  Created by Алексей Папин on 20.08.2018.
//

import Vapor
import FluentSQLite

final class Controller<T: SQLiteModel> {
    func getAll(_ req: Request) throws -> Future<[T]> {
        return T.query(on: req).all()
    }
    
    func get(_ req: Request) throws -> Future<T> {
        let id = try req.parameters.next(Int.self)
        return T.find(id, on: req).unwrap(or: Abort(.notFound))
    }
    
    func create(_ req: Request) throws -> Future<T> {
        return try req.content.decode(T.self).flatMap { user in
            return user.save(on: req)
        }
    }
    
    func delete(_ req: Request) throws -> Future<T> {
        let id = try req.parameters.next(Int.self)
        return T.find(id, on: req).unwrap(or: Abort(.notFound)).delete(on: req)
    }
}

extension Controller where T == User {
    func getPosts(_ req: Request) throws -> Future<[Post]> {
        let userId = try req.parameters.next(Int.self)
        return Post.query(on: req).filter(\.userId == userId).all()
    }
    
    func getComments(_ req: Request) throws -> Future<[Comment]> {
        let userId = try req.parameters.next(Int.self)
        return Comment.query(on: req).filter(\.userId == userId).all()
    }
}

extension Controller where T == Post {
    func getComments(_ req: Request) throws -> Future<[Comment]> {
        let postId = try req.parameters.next(Int.self)
        return Comment.query(on: req).filter(\.postId == postId).all()
    }
}
