//
//  DetailViewController.swift
//  GetItDone
//
//  Created by Srini Motheram on 1/30/17.
//  Copyright © 2017 Srini Motheram. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
        @IBOutlet var saveButton            :UIBarButtonItem!
        @IBOutlet var taskNameTextField    :UITextField!
        @IBOutlet var priorityZoneTextField     :UITextField!
        @IBOutlet var dateCreatedTextField        :UITextField!
        
        var currentTask  :Task?
        var managedContext :NSManagedObjectContext!
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
        
        //MARK :- CORE METHODS
        
        func display(task: Task){
            taskNameTextField.text = task.taskName
            dateCreatedTextField.text = task.taskName
            priorityZoneTextField.text     = task.priorityZone
            
        }
        
        func setTaskValues(task: Task){
            task.taskName = taskNameTextField.text
            task.dateCreated = NSDate()
            task.priorityZone = priorityZoneTextField.text
            
        //    if let _ = currentTask {
         //       task.dateUpdated = NSDate()
        //    } else { task.dateEntered = NSDate() }
            
        }
        
        func createTask(){
            let newTask = NSEntityDescription.insertNewObject(forEntityName: "Task", into: managedContext) as! Task
            setTaskValues(task: newTask)
            appDelegate.saveContext()
            
        }
        
        func editTask(task: Task){
            setTaskValues(task: task)
            appDelegate.saveContext()
        }
    
        //MARK :- INTERACTIVITY METHODS
        
        @IBAction func savePressed(button: UIBarButtonItem){
            
            if let task = currentTask {
                editTask(task: task)
            } else {
                createTask()
                
            }
            self.navigationController!.popViewController(animated: true)
        }
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            managedContext = appDelegate.persistentContainer.viewContext
            if let task = currentTask {
                display(task: task)
                
            }
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
        
        
    }


