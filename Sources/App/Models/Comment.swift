//
//  Comment.swift
//  App
//
//  Created by Алексей Папин on 20.08.2018.
//

import FluentSQLite
import Vapor

final class Comment: SQLiteModel {
    static let name = "comments"
    
    var id      : Int?
    let date    : Date
    let userId  : Int
    var text    : String
    var postId  : Int
    
    init(id: Int? = nil, userId: Int, text: String, postId: Int) {
        self.id = id
        self.date = Date()
        self.userId = userId
        self.text = text
        self.postId = postId
    }
}

extension Comment {
    var post: Parent<Comment, Post> {
        return parent(\.postId)
    }
    
    var user: Parent<Comment, User> {
        return parent(\.userId)
    }
}

extension Comment: Migration { }
extension Comment: Content { }
extension Comment: Parameter { }
