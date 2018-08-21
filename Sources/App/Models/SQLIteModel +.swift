//
//  SQLiteModel +.swift
//  App
//
//  Created by Алексей Папин on 21.08.2018.
//

import Vapor
import FluentSQLite

extension Application {
    func getDatabase<T>(with closure: @escaping (DatabaseConnectable) -> (Future<T>)) -> Future<T> {
        return self.withNewConnection(to: .sqlite) { db in
            return closure(db)
        }
    }
}

extension SQLiteModel {
    func save(in app: Application) -> Future<Self> {
        return app.withNewConnection(to: .sqlite) { db in
            self.save(on: db)
        }
    }
    
    func update(in app: Application) -> Future<Self> {
        return app.withNewConnection(to: .sqlite) { db in
            self.update(on: db)
        }
    }
    
    func delete(in app: Application) -> Future<Void> {
        return app.withNewConnection(to: .sqlite) { db in
            self.delete(on: db)
        }
    }
    
    func read(in app: Application) -> Future<Self?> {
        return app.withNewConnection(to: .sqlite) { db in
            Self.query(on: db).first()
        }
    }
}

extension Array where Element: SQLiteModel {
    func save(in app: Application) -> Future<[Element]> {
        return app.withNewConnection(to: .sqlite) { db in
            return self.map { obj -> Future<Element> in
                return obj.save(on: db)
                }.flatten(on: db)
        }
    }
}
