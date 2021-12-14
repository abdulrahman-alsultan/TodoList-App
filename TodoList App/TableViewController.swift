//
//  ViewController.swift
//  TodoList App
//
//  Created by admin on 14/12/2021.
//

import UIKit
import CoreData

class TableViewController: UITableViewController, AddTaskDelegate {
    
    let manageObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    
    func add(by controller: AddViewController, title: String, desc: String, percentage: Int, date: String, at indecPath: NSIndexPath?) {
        if let ip = indecPath{
            let task = todoList[ip.row]
            task.todoPercentage = Int16(percentage)
            task.todoDate = date
            task.todoTitle = title
            task.todoDescription = desc
        }else{
            let task = NSEntityDescription.insertNewObject(forEntityName: "ToDoList", into: manageObjectContext) as! ToDoList
            task.todoDate = date
            task.todoTitle = title
            task.todoDescription = desc
            task.todoPercentage = Int16(percentage)
            todoList.append(task)
        }
        
        do{
            try manageObjectContext.save()
        }catch {
            print("\(error)")
        }
        
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
        
    }
    
    func cancel(by controller: AddViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    var todoList = [ToDoList]()
    
    func fetchAllTasks(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoList")
        
        do{
            let result = try manageObjectContext.fetch(request)
            todoList = result as! [ToDoList]
        }catch{
            print("\(error)")
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchAllTasks()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! CustomTableViewCell
        
        cell.setCell(t: todoList[indexPath.row].todoTitle!, d: todoList[indexPath.row].todoDate!, n: todoList[indexPath.row].todoDescription!)
        
        if todoList[indexPath.row].todoPercentage == 100{
            cell.completed.isHidden = false
        }
        else{
            cell.completed.isHidden = true
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "EditTask", sender: indexPath)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender is UIBarButtonItem{
            let navigationController = segue.destination as! UINavigationController
            let addViewController = navigationController.topViewController as! AddViewController
            addViewController.delegate = self
        }
        else if sender is NSIndexPath{
            let navigationController = segue.destination as! UINavigationController
            let addViewController = navigationController.topViewController as! AddViewController
            addViewController.delegate = self
            
            let indexPath = sender as! NSIndexPath
            
            addViewController.n = todoList[indexPath.row].todoDescription
            addViewController.t = todoList[indexPath.row].todoTitle
            addViewController.d = todoList[indexPath.row].todoDate
            addViewController.p = Int(todoList[indexPath.row].todoPercentage)
            addViewController.indexPath = indexPath
        }
    }

}

