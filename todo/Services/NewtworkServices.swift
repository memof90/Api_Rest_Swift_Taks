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
    
    func getTodos(onSucees: @escaping (Todos) -> Void) {
        let url = URL(string: "\(URL_BASE)")!

        let task = session.dataTask(with: url) { (data, response, error) in
            
//            Grand central Dispath es le sistema de enhebrado contruido por ios
//            para hacer solictidus URLSession de manera asyncrona y cuyas tareas se ejecuten en segundo plano
            DispatchQueue.main.async {
                if let error = error {
                    debugPrint(error.localizedDescription)
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    debugPrint("Invalid data or response")
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
                        
                    }
                    
                } catch {
                    debugPrint(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    func addTodos(todo: Todo) {
        
    }
}
