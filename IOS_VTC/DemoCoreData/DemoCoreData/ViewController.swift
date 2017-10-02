//
//  ViewController.swift
//  DemoCoreData
//
//  Created by Nguyen Nam on 8/21/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    var managerObjectContext:NSManagedObjectContext?
    var _fetchedResultsController:NSFetchedResultsController<Task>?
    
    // The proxy variable to serve as a lazy getter to our
    // fetched results controller.
    var fetchedResultsController:NSFetchedResultsController<Task>{
        if _fetchedResultsController != nil{
            return _fetchedResultsController!
        }
        
        // If not, lets build the required elements for the fetched
        // results controller
        
        let fetchRequest:NSFetchRequest<Task> = Task.fetchRequest()
        // Set the batch size to a suitable number (optional).
        
        fetchRequest.fetchBatchSize = 20
        // Create at least one sort order attribute and type (ascending\descending)
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        //
        //        let predicate = NSPredicate(format: "compeleted = false")
        //
        //        fetchRequest.predicate = predicate
        
        let aFetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managerObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        
        aFetchResultController.delegate = self
        _fetchedResultsController = aFetchResultController
        do{
            try _fetchedResultsController!.performFetch()
        }catch{
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return _fetchedResultsController!
    }
    
    @IBOutlet weak var taskTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        taskTable.delegate = self
        taskTable.dataSource = self
        
        /*
        let classEntity:Class = NSEntityDescription.insertNewObject(forEntityName: "Class", into: managerObjectContext!) as! Class
        classEntity.name = "MD05"
        classEntity.maxStudent = 2
        
        let student:Student = NSEntityDescription.insertNewObject(forEntityName: "Student", into: managerObjectContext!) as! Student
        student.rollNo = "0002"
        student.name = "Nguyen A"
        student.address = "Ha Noi"
        student.birthday = NSDate()
        //        student.class_name = classEntity
        
        */
        let student2:Student = NSEntityDescription.insertNewObject(forEntityName: "Student", into: managerObjectContext!) as! Student
        student2.rollNo = "0007"
        student2.name = "Nguyen Ccccccs"
        student2.address = "Ha tay"
        student2.birthday = NSDate()
        //        student2.class_name = classEntity
        
        //
        //
        //        classEntity.student_list?.adding(student)
        //        classEntity.student_list?.adding(student2)
        //
        do{
            try managerObjectContext?.save()
        }catch {
            NSLog("Error save entities")
        }
        /*
        let fetchResultClass:NSFetchRequest<Class> = Class.fetchRequest()
        do{
            let c =  try managerObjectContext?.fetch(fetchResultClass)
            let students:Set<Student> = c?.first?.student_list as! Set<Student>
            for s in students {
                print(s.name)
            }
        }catch{
            NSLog("Error")
        }
        */
        let fetchResultStudent:NSFetchRequest<Student> = Student.fetchRequest()
        
        do{
            let sss =  try managerObjectContext?.fetch(fetchResultStudent)
            print(sss?.count)
            for s in sss! {
                print(s.name)
            }
        }catch{
            NSLog("Error")
        }
 
        
//        let stu:Student = Student(context: managerObjectContext!)
//        stu.name = "Name 6"
//        stu.birthday = NSDate()
//        stu.rollNo = "0005"
//        do{
//            try managerObjectContext?.save()
//        }catch let error as Error?{
//            NSLog("Error \(error)")
//        }
//        let fetchRequest:NSFetchRequest<Student> = Student.fetchRequest()
//        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//        let fetch:NSFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managerObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
//        do{
//            try fetch.performFetch()
//        }catch{
//            
//        }
        
//        do{
//            let c = try managerObjectContext?.fetch(fetchRequest)
//            print((c?.last?.name)!)
//        }catch{
//            
        
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let task = self.fetchedResultsController.object(at: indexPath)
        
        cell.detailTextLabel?.text = task.completed ? "True" : "False"
        cell.textLabel?.text = task.name
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addTask(_ sender: Any) {
        //        let context = managerObjectContext!
        // using manager object context to entry into entity Task
        if managerObjectContext != nil{
            let object = NSEntityDescription.insertNewObject(forEntityName: "Task", into: managerObjectContext!) as! Task
            object.name = Date().description
            object.completed = false
            do{
                try managerObjectContext!.save()
            }catch{
                NSLog("Error ")
            }
            
            taskTable.reloadData()
        }
        else{
            NSLog("Manager nil")
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        // whenever a user swipe a cell , it will show two options
        
        //a option to mark a task completed
        
        let completeAction = UITableViewRowAction(style: .normal, title: "Complete") { (tableRowAction, indexPath) in
            self.markCompletedTaskIn(indexPath)
        }
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (tableRowAction, indexPath) in
            self.deleteTaskIn(indexPath)
        }
        return [completeAction,deleteAction]
    }
    
    func markCompletedTaskIn(_ indexPath:IndexPath){
        // To mark a task completed we retrieve the corresponding
        // object from the cell index.
        let task = self.fetchedResultsController.object(at: indexPath)
        // Update the attribute
        task.completed = true
        do {
            // And try to persist the change. If successfull
            // the fetched results controller will react and call the method
            // to reload the table view.
            try self.managerObjectContext?.save()
        } catch {}
    }
    
    func deleteTaskIn(_ indexPath:IndexPath){
        let task = self.fetchedResultsController.object(at: indexPath)
        
        self.managerObjectContext?.delete(task)
    
        do{
            try self.managerObjectContext?.save()
        }
        catch{
            
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        taskTable.reloadData()
    }
    
}

