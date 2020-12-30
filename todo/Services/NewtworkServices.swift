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
    
    func getTodos(onSucees: @escaping (Todos) -> Void, onError: @escaping (String) -> Void) {
        let url = URL(string: "\(URL_BASE)")!

        let task = session.dataTask(with: url) { (data, response, error) in
            
//            Grand central Dispath es le sistema de enhebrado contruido por ios
//            para hacer solictidus URLSession de manera asyncrona y cuyas tareas se ejecuten en segundo plano
            DispatchQueue.main.async {
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid data or response")
                    return
                }
                
    //            MARK: Tenemos que manejar los errores 500 or 400 o exito 200
                do {
                    
                    if response.statusCode == 200 {
        //                parse successful result (todos)
                        let items = try JSONDecoder().decode(Todos.self, from: data)
    //                    handle success
                        onSucees(items)
                        
                    } else {
        //                show error to user
                        let err = try JSONDecoder().decode(APIError.self, from: data)
    //                    handle erorr
                        onError(err.message)
                    }
                    
                } catch {
                    onError(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    func addTodos(todo: Todo, onSucees: @escaping (Todos) -> Void, onError: @escaping (String) -> Void) {
        let url = URL(string: "\(URL_BASE)\(URL_ADD_TODO)")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST" //GET, PUR, POST, DELETE
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            let body = try JSONEncoder().encode(todo)
            request.httpBody = body
            
            let task = session.dataTask(with: request) { (data, response, error) in
                
                DispatchQueue.main.async {
                    
                    if let error = error {
    //                    error
                        onError(error.localizedDescription)
                        return
                    }
                    guard let data = data, let response = response as? HTTPURLResponse else {
    //                    error
                        onError("Invalid data or response")
                        return
                    }
                    do {
                        if response.statusCode == 200 {
                            let items = try JSONDecoder().decode(Todos.self, from: data)
    //                        onSucess
                            onSucees(items)
                        } else {
                            let err = try JSONDecoder().decode(APIError.self, from: data)
    //                        onError
                            onError(err.message)
                        }
                    } catch {
    //                    err
                        onError(error.localizedDescription)
                    }
                    
                }
            }
            task.resume()
        } catch {
//            err
            onError(error.localizedDescription)
        }
        
        
    }
}
