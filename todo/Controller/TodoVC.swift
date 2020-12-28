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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //    MARK: IBAction
    @IBAction func addTodo(_ sender: Any) {
        
    }
    
}

