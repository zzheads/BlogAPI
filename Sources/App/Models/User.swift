//
//  User.swift
//  App
//
//  Created by Алексей Папин on 20.08.2018.
//

import FluentSQLite
import Vapor

final class User: Codable, SQLiteModel {
    static let name = "users"
    
    var id          : Int?
    var email       : String
    var password    : String
    
    init(id: Int? = nil, email: String, password: String) {
        self.id = id
        self.email = email
        self.password = password
    }
}

extension User {
    var posts: Children<User, Post> {
        return children(\.userId)
    }
    
    var comments: Children<User, Comment> {
        return children(\.userId)
    }
}

extension User: Migration { }
extension User: Content { }
extension User: Parameter { }
