//
//  ViewController.swift
//  todo
//
//  Created by Memo Figueredo on 28/12/20.
//

import UIKit

class TodoVC: UIViewController {
    
    
//    MARK: IBOutlet

    @IBOutlet weak var todoItemTxt: UITextField!
    
    @IBOutlet weak var prioritySegment: UISegmentedControl!
    
    @IBOutlet weak var todoTable: UITableView!
    
//    MARK: variables
    var todos = Array<Todo>()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //call protocol before call data to api first see table before see data
        todoTable.delegate = self
        todoTable.dataSource = self
        // function to solicitud newtwork api
        getTodos()
//        fuction to post data
        addTodos()
    }
    
    
//    MARK: Fucntions
    func getTodos(){
        NetworkService.shared.getTodos { (todos) in
            debugPrint(todos)
            self.todos = todos.items
            self.todoTable.reloadData()
        } onError: { (errorMessage) in
            debugPrint(errorMessage)
        }

    }
    
    func addTodos() {
        NetworkService.shared.addTodos(todo: Todo(item: "Test", priority: 2)) { (todos) in
            debugPrint(todos)
            self.todos = todos.items
            self.todoTable.reloadData()
        } onError: { (errorMessage) in
            debugPrint(errorMessage)
        }

    }
    
    //    MARK: IBAction
    @IBAction func addTodo(_ sender: Any) {
        
    }
    
}

extension TodoVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell") as? TodoCell else {
            return UITableViewCell()
        }
        cell.updateCell(todo: todos[indexPath.row])
        return cell
//        if let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell") as? TodoCell {
//
//        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
