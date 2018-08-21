//
//  Post.swift
//  App
//
//  Created by Алексей Папин on 20.08.2018.
//

import FluentSQLite
import Vapor

final class Post: SQLiteModel {
    static let name = "posts"
    
    var id      : Int?
    let date    : Date
    let userId  : Int
    var text    : String
    
    init(id: Int? = nil, userId: Int, text: String) {
        self.id = id
        self.date = Date()
        self.userId = userId
        self.text = text
    }
}

extension Post {
    var comments: Children<Post, Comment> {
        return children(\.postId)
    }
    
    var user: Parent<Post, User> {
        return parent(\.userId)
    }
}



extension Post: Migration { }
extension Post: Content { }
extension Post: Parameter { }
