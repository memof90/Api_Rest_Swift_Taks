//
//  NewtworkServices.swift
//  todo
//
//  Created by Memo Figueredo on 28/12/20.
//

import Foundation

//service singleton

class NetworkService {
//    Instance
    static let shared = NetworkService()
    
//    URL-SERVER
//    root: basic '/'
    let URL_BASE = "http://localhost:3003"
//    root: add '/add'
    let URL_ADD_TODO = "/add"
    
    let session = URLSession(configuration: .default)
    
    func getTodos() {
        let url = URL(string: "\(URL_BASE)")!

        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
        }
        task.resume()
    }
    
    func addTodos(todo: Todo) {
        
    }
}
