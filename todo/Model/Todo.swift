//
//  Todo.swift
//  todo
//
//  Created by Memo Figueredo on 28/12/20.
//

import Foundation

struct Todos: Codable {
    let items: Array<Todo>
}

struct Todo: Codable {
     let item: String
     let  priority: Int
}
